import 'package:citizen_107/common/menutile.dart';
import 'package:citizen_107/home_screen/fuctions_screen/helpline_screen.dart';
import 'package:citizen_107/home_screen/fuctions_screen/pharmacy_screen.dart';
import 'package:citizen_107/home_screen/fuctions_screen/video_scren.dart';
import 'package:citizen_107/home_screen/help_me_screens/help_me_option_screen.dart';
import 'package:citizen_107/home_screen/type_of_hospital/type_of_hospital_screen.dart';
import 'package:citizen_107/login_screen/login_screen.dart';
import 'package:citizen_107/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
              onSelected: (String value) {
                // This is where the magic happens
                switch (value) {
                  case 'account':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'account', // Assign a value to identify the choice
                  child: Text('ACCOUNT'),
                ),
              ],
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //header text
                  const Text(
                    'Emergency Help Available 24/7',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  // SOS CIRCLE
                  SosCircle(),
                  const SizedBox(height: 20),
                  const Text(
                    'Other Option For Your Use',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1A1F36),
                      height: 1.5, // Adds spacing between lines
                    ),
                  ),
                  const SizedBox(height: 30),
                  //bottom manu
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2, //2 column
                    crossAxisSpacing: 16, //hori space
                    mainAxisSpacing: 16, // varti space
                    childAspectRatio: 1.4, // hight and width ration adjusts
                    children: [
                      MenuTile(
                        icon: Icons.local_pharmacy,
                        label: 'pharmacy',
                        secondLabel: '',
                        iconColor: Colors.deepPurple,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PharmacyScreen(),
                            ),
                          );
                        },
                      ),
                      MenuTile(
                        icon: Icons.local_hospital,
                        label: 'hospital',
                        secondLabel: '',
                        iconColor: Colors.pinkAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TypeOfHospitalScreen(),
                            ),
                          );
                        },
                      ),
                      MenuTile(
                        icon: Icons.help, // Closest stock icon for caregivers
                        label: 'Helpline Numbers',
                        secondLabel: '',
                        iconColor: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HelplineScreen(),
                            ),
                          );
                        },
                      ),
                      MenuTile(
                        icon: Icons.ondemand_video,
                        label: 'Video tutorial',
                        secondLabel: '',
                        iconColor: Colors.grey.shade600,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VideoScren(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  //login or singin
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFEDF1F7,
                          ), // Light grey-blue background
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'BECOME A VOLUNTEER...',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1F36),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// sos circle
class SosCircle extends StatelessWidget {
  const SosCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HelpMeOptionScreen()),
        );
      },
      borderRadius: BorderRadius.circular(150),
      child: Container(
        height: 260,
        width: 260,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Colors.redAccent.shade200, const Color(0xFFD32F2F)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.3),
              blurRadius: 30,
              spreadRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The inner pinkish SOS icon box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: const Text(
                'HELP ME..',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
