import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class HelpMeLocationScreen extends StatefulWidget {
  final String? typeOfIngery;
  const HelpMeLocationScreen({super.key, required this.typeOfIngery});

  @override
  State<HelpMeLocationScreen> createState() => _HelpMeLocationScreenState();
}

class _HelpMeLocationScreenState extends State<HelpMeLocationScreen> {
  String _cityName = "Featching location...";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _cityName = "Location services disabled";
        _isLoading = false;
      });
      return;
    }

    // 2. Handle Permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _cityName = "Permission denied";
          _isLoading = false;
        });
        return;
      }
    }

    // 3. Get Coordinates
    Position position = await Geolocator.getCurrentPosition();

    // 4. Get City Name (Geocoding)
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

      setState(() {
        _cityName = place.locality ?? "Unknown City";
        _isLoading = false;
      });

      // 5. Trigger your messaging function here
      // Inside _determinePosition, change the call to:
      if (mounted) {
        _sendHelpNotification(
          context,
          _cityName,
          position.latitude,
          position.longitude,
        );
      }
    } catch (e) {
      setState(() {
        _cityName = "Error finding city";
        _isLoading = false;
      });
    }
  }

  Future<void> _sendHelpNotification(
    BuildContext context,
    String cityName,
    double lat,
    double lng,
  ) async {
    cityName =cityName.toLowerCase();
    try {
      // 1. QUERY FIRESTORE FOR QUALIFIED VOLUNTEERS
      // We only want volunteers in this city AND whose status is 'available'
      final snapshot = await FirebaseFirestore.instance
          .collection('_USERS')
          .where('serviceCity', isEqualTo: cityName)
          .where('status', isEqualTo: 'approved') // Only approved/available
          .get();

      if (snapshot.docs.isEmpty) {
        _showMsg(context, "No available volunteers found in $cityName.");
        return;
      }

      // 2. EXTRACT THEIR FCM TOKENS
      List<String> tokens = snapshot.docs
          .map((doc) => doc.data()['fcmToken'] as String?)
          .where((token) => token != null)
          .cast<String>()
          .toList();

      if (tokens.isEmpty) {
        _showMsg(context, "Volunteers found, but none have active devices.");
        return;
      }

      // 3. PREPARE THE SERVICE ACCOUNT & CLIENT
      Map<String, dynamic> getServiceAccount() {
  return {
    "type": "service_account",
    "project_id": dotenv.env['GCP_PROJECT_ID'],
    "private_key_id": dotenv.env['GCP_PRIVATE_KEY_ID'],
    // This replaceAll is critical for the key to be read correctly
    "private_key": dotenv.env['GCP_PRIVATE_KEY']?.replaceAll(r'\n', '\n'),
    "client_email": dotenv.env['GCP_CLIENT_EMAIL'],
    "client_id": "112024237652212894056",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/...",
    "universe_domain": "googleapis.com",
  };
}
      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
      final credentials = auth.ServiceAccountCredentials.fromJson(
        getServiceAccount(),
      );
      final client = await auth.clientViaServiceAccount(credentials, scopes);

      // 4. SEND TO SPECIFIC TOKENS (Multicast)
      final String url =
          'https://fcm.googleapis.com/v1/projects/citizen-107-a2440/messages:send';

      // Loop through tokens to send individual messages
      // (Or use a multicast endpoint if your library supports it)
      for (String token in tokens) {
        final payload = {
          "message": {
            "token": token, // TARGET SPECIFIC USER
            "notification": {
              "title": "🚨 EMERGENCY: $cityName",
              "body": "An approved volunteer is needed immediately!",
            },
            "data": {
              "lat": lat.toString(),
              "lng": lng.toString(),
              "type": "emergency_alert",
            },
          },
        };

        await client.post(
          Uri.parse(url),
          body: jsonEncode(payload),
          headers: {'Content-Type': 'application/json'},
        );
      }

      _showMsg(context, "Alert sent to ${tokens.length} approved volunteers.");
      client.close();
    } catch (e) {
      _showMsg(context, "Error: $e");
    }
  }

  // Helper function to show a SnackBar
  void _showMsg(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('citizen 107')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Center(child: Text('You have ${widget.typeOfIngery}')),
                SizedBox(height: 20),
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator() // Show spinner while loading
                      : Column(
                          children: [
                            Text(
                              'Your City: $_cityName',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Your location is being shared with volunteers.',
                            ),
                          ],
                        ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'List of Volunter Worker that can get ther to work',
                  ),
                ),
                SizedBox(height: 20),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
