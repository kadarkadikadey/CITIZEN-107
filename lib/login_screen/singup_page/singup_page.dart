import 'package:citizen_107/common/costom_button.dart';
import 'package:citizen_107/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

// Import Firestore
class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _yourservicecityController =
      TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _linktodocController = TextEditingController();

  bool _isLoading = false;

  // 2. The Signup Logic
  Future<void> _signUp() async {
    // Basic validation
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match!")));
      return;
    }

    setState(() => _isLoading = true);
    if (!mounted) return;

    try {
      // Step A: Create user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
      await userCredential.user!.sendEmailVerification();
      if (!mounted) return;
      // Run this when a volunteer sets their city
      // Get the city name for topic subscription
      // 2. If login is successful, get the UID and update the token

      // 2. Subscribe the volunteer to their specific city topic
      // This allows your app to communicate with all volunteers in that city at once
      // Step B: Save extra details to Firestore using the User's UID
      await FirebaseFirestore.instance
          .collection('_USERS')
          .doc(userCredential.user!.uid)
          .set({
            'uid': userCredential
                .user!
                .uid, // UID is usually alpha-numeric case sensitive, leave as is
            'fullName': _nameController.text.trim().toLowerCase(),
            'email': _emailController.text.trim(),
            'phone': _phoneController.text.trim(), // Numbers don't have case
            'address': _addressController.text.trim().toLowerCase(),
            'gender': _genderController.text.trim().toLowerCase(),
            'dob': _dobController.text
                .trim(), // Date formats usually don't need lowercase
            'aadhar': _aadharController.text.trim(),
            'serviceCity': _yourservicecityController.text.trim().toLowerCase(),
            'status': 'pending',
            'createdAt': FieldValue.serverTimestamp(),
            'Linktodoc': _linktodocController.text.trim(),
          });
      if (!mounted) return;

      // --- ADDED TOPIC SUBSCRIPTION HERE ---
      // Format city name for topic (ensuring it is lowercase)
      String city = _yourservicecityController.text.trim().toLowerCase();
      if (city.isNotEmpty) {
        // Now it will consistently be "city_samarkha"
        String topicName = "city_${city.replaceAll(' ', '_')}";
        await FirebaseMessaging.instance.subscribeToTopic(topicName);
      }
      // -------------------------------------

      // Step C: Navigate to Home
      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        // CALL YOUR FUNCTION HERE
        await updateVolunteerToken(uid);
      }

      if (!mounted) return;

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Authentication failed")),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    } finally {
      // Only stop loading if we haven't navigated away
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
            .collection('_USERS') // or '_USERS' based on your error log
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
                padding: const EdgeInsetsGeometry.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Welcome to Citizen 107',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '==>  Happy to see you That you are willing to intrested in volantier work for your neaiber emergancy',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '==>  please filll your detail about your self to get start  do volantier work ',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField('Full Name', _nameController),
                    const SizedBox(height: 20),
                    _buildTextField(
                      'Email Address',
                      _emailController,
                      isEmail: true,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField('Phone Number', _phoneController),
                    const SizedBox(height: 20),
                    _buildTextField('Address', _addressController),
                    const SizedBox(height: 20),
                    _buildTextField('Gender', _genderController),
                    const SizedBox(height: 20),
                    _buildTextField('BirthDate [dd/mm/yyyy]', _dobController),
                    const SizedBox(height: 20),
                    _buildTextField(
                      'Your Service City',
                      _yourservicecityController,
                    ),

                    const SizedBox(height: 20),
                    _buildTextField('Aadhar Card Number', _aadharController),
                    const SizedBox(height: 20),
                    _buildTextField(
                      'Create Password',
                      _passwordController,
                      isPass: true,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      'Conform Password',
                      _confirmPasswordController,
                      isPass: true,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      '==>  please upload your documant in google drive about your madical or helper archivmant or cirtificates.... ',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '==> after upload your documant in goggle drive pest your drive link hear  ',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    _buildTextField('Pest link of documant', _linktodocController),
                    const SizedBox(height: 30),
                    const Text(
                      '==>  for varifing your documant take 2 or 3 days so your login process take 2 or 3 days after submiting your information ',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    CostomButton(text: 'submit', onPressed: _signUp),
                    const SizedBox(height: 30),
                    const Text(
                      '==>  After 2 or 3 Days You Gain Conformation mail or message in your MailBox, ',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
    );
  }
}

Widget _buildTextField(
  String label,
  TextEditingController controller, {
  bool isPass = false,
  bool isEmail = false,
}) {
  return TextField(
    controller: controller,
    obscureText: isPass,
    keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
    decoration: InputDecoration(
      labelText: label,
      // The default border (Grey)
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.grey),
      ),
      // The border when the field is selected (Deep Purple)
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
      ),
      // Optional: adds the grey color specifically to the enabled border
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
  );
}
