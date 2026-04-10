import 'package:citizen_107/home_screen/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("User not logged in. Please login to see your profile."),
        ),
      );
    }

    return (Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Image.asset(
            'assets/images/LOGO_ORIGINAL_01.png', // Path to your image
            fit: BoxFit.contain,
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text('CITIZEN 107'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {},
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'feedback', child: Text('FEEDBACK')),
              const PopupMenuItem(value: 'help', child: Text('HELP')),
              const PopupMenuItem(value: 'contact', child: Text('CONTACT US')),
            ],
          ),
        ],
      ),
      body: uid == null
          ? const Center(child: Text("No user logged in"))
          : FutureBuilder<DocumentSnapshot>(
              // Fetch the specific document for this user
              future: FirebaseFirestore.instance
                  .collection('_USERS')
                  .doc(uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading profile"));
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text("Profile not found"));
                }

                // Map the Firestore data
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.deepPurple,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildProfileItem("Full Name", data['fullName']),
                      _buildProfileItem("Email", data['email']),
                      _buildProfileItem("Phone", data['phone']),
                      _buildProfileItem("Address", data['address']),
                      _buildProfileItem("Gender", data['gender']),
                      _buildProfileItem("Date of Birth", data['dob']),
                      _buildProfileItem("Aadhar Number", data['aadhar']),
                      const Divider(),
                      const SizedBox(height: 10),
                      Center(child: _buildStatusBadge(data['status'])),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () async {
                            String city = data['serviceCity'] ?? "unknown";
                            String topic =
                                "city_${city.replaceAll(" ", "_").toLowerCase()}";
                            await FirebaseMessaging.instance
                                .unsubscribeFromTopic(topic);

                            SnackBar(
                              content: Text("Unsubscribed from $topic"),
                              backgroundColor: Colors.redAccent,
                              duration: const Duration(seconds: 5),
                              behavior: SnackBarBehavior
                                  .floating, // Makes it look like a popup
                            );
                            await FirebaseMessaging.instance.deleteToken();
                            // 1. Perform the async operation
                            await FirebaseAuth.instance.signOut();

                            // 2. The proper check for a StatefulWidget's State
                            if (!mounted) return;

                            // 3. Now navigate using the context
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                              (route) => false,
                            );
                          },

                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
      //header text}
    ));
  }

  // Helper to build rows of data
  Widget _buildProfileItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 5),
          Text(
            value ?? "Not provided",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Helper to show the verification status
  Widget _buildStatusBadge(String? status) {
    Color color = status == 'approved' ? Colors.green : Colors.orange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        "Status: ${status?.toUpperCase() ?? 'PENDING'}",
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
