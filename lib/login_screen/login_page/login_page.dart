import 'package:citizen_107/common/costom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:citizen_107/profile_screen/profile_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      // 1. Authenticate with Firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      if (!mounted) return;
      String uid = userCredential.user!.uid;

      // 2. Fetch User Profile from Firestore to get the City
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('_USERS')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        // Get the city (and handle potential null values safely)
        String? city = userDoc.get('serviceCity');

        if (city != null && city.isNotEmpty) {
          // 3. Clean the city name and Subscribe
          // We use lowercase to match our signup and sending logic
          String topicName =
              "city_${city.trim().replaceAll(' ', '_').toLowerCase()}";

          await FirebaseMessaging.instance.subscribeToTopic(topicName);
          SnackBar(
            content: Text("login successfully"),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 5),
            behavior: SnackBarBehavior.floating, // Makes it look like a popup
          );
        }

        // 4. Update the individual FCM token (for direct messages)
        await updateVolunteerToken(uid);
      }

      if (!mounted) return;
      // 2. Redirect to Profile Page on Success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Login Failed")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> updateVolunteerToken(String volunteerUid) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 1. Request permission (Required for iOS and Android 13+)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 2. Get the unique token for this device
      String? token = await messaging.getToken();

      if (token != null) {
        // 3. Save it to the specific volunteer document in Firestore
        await FirebaseFirestore.instance
            .collection('_USERS')
            .doc(volunteerUid)
            .update({
              'fcmToken': token,
              'lastUpdated': FieldValue.serverTimestamp(),
            });

        SnackBar(
          content: Text("Token updated for volunteer: $volunteerUid"),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating, // Makes it look like a popup
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CITIZEN 107')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Welcome...',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '==> Happy To See You Doing Volunter Working For Your Neighberhood ',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '==> Enter Your Email and Password To Continew ',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 40),
                    _buildTextField('Email Address', _emailController, false),
                    const SizedBox(height: 20),
                    _buildTextField('Password', _passwordController, true),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Handle forgot password
                        },
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CostomButton(text: 'login', onPressed: _login),
                  ],
                ),
              ),
            ),
    );
  }
}

Widget _buildTextField(
  String label,
  TextEditingController controller,
  bool isPass,
) {
  return TextField(
    controller: controller,
    obscureText: isPass,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.deepPurple),
      ),
    ),
  );
}
