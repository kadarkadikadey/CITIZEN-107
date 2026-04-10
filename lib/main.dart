import 'package:citizen_107/leading_screen/leading_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:url_launcher/url_launcher.dart';

Future<void> _openMap(String? lat, String? lng) async {
  if (lat == null || lng == null) return;

  // 1. Format the URLs correctly
  // Use the googleusercontent.com/maps.google.com/1 format for universal compatibility
  final String googleMapsUrl =
      "https://www.google.com/maps/search/?api=1&query=22.6038417,72.98444";

  // Apple Maps format for iOS
  final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

  try {
    if (Theme.of(scaffoldMessengerKey.currentContext!).platform ==
        TargetPlatform.iOS) {
      // Logic for iOS
      if (await canLaunchUrl(Uri.parse(appleMapsUrl))) {
        await launchUrl(
          Uri.parse(appleMapsUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } else {
      // Logic for Android
      if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(
          Uri.parse(googleMapsUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        // Fallback: Open in Browser if the app isn't there
        await launchUrl(
          Uri.parse(googleMapsUrl),
          mode: LaunchMode.platformDefault,
        );
      }
    }
  } catch (e) {
    debugPrint("Error: $e");
    scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(content: Text("Could not launch Maps application.")),
    );
  }
}

// 1. THIS KEY IS ESSENTIAL - It allows showing UI elements without 'context'
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
// 1. Create the channel object
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id (must match your FCM payload)
  'Emergency Alerts', // title
  description: 'This channel is used for CITIZEN-107 emergency notifications.',
  importance: Importance.high, // This enables the BANNER
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Background handler must be a top-level function
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  SnackBar(
    content: Text("Handling a background message: ${message.messageId}"),
    backgroundColor: Colors.redAccent,
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating, // Makes it look like a popup
  );
}

void main() async {
  // 2. Standard Flutter/Firebase setup (Only do this once)
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // 2. Initialize the plugin and create the channel
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  // 3. Set foreground notification options for Apple/Android
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // 3. Set up the Background listener
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 4. Set up the Foreground listener (Shows SnackBar when app is OPEN)
  // 4. Updated Foreground listener with Action Button
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Ensure these match the keys you sent in the payload ('lat' and 'lng')
    final String? lat = message.data['lat'];
    final String? lng = message.data['lng'];

    if (message.notification != null) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("${message.notification!.title}"),
          backgroundColor: Colors.redAccent,
          action: SnackBarAction(
            label: "GO",
            textColor: Colors.white,
            onPressed: () => _openMap(lat, lng), // Pass them here
          ),
        ),
      );
    }
  });

  // Handle interaction when app is in background/terminated
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    final String? lat = message.data['lat'];
    final String? lng = message.data['lng'];
    _openMap(lat, lng);
  });

  // Load the environment variables
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 5. CRITICAL: Register the key here so the listener can find it
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'CITIZEN 107',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const LeadingScreen(),
    );
  }
}
