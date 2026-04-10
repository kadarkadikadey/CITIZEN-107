import 'package:citizen_107/common/menutile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class HelplineScreen extends StatelessWidget {
  const HelplineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('citizen 107')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2, //2 column
                  crossAxisSpacing: 16, //hori space
                  mainAxisSpacing: 16, // varti space
                  childAspectRatio: 1.4, // hight and width ration adjusts
                  children: [
                    MenuTile(
                      icon: Icons.add_alert,
                      label: 'Ambulance',
                      secondLabel: '102',
                      iconColor: Colors.deepPurple,
                      onTap: () async {
                        final Uri launchUri = Uri(scheme: 'tel', path: '102');

                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the error, e.g., show a snackbar if the device has no dialer
                          debugPrint('Could not launch $launchUri');
                        }
                      },
                    ),
                    MenuTile(
                      icon: Icons.warning,
                      label: 'Police',
                      secondLabel: '100',
                      iconColor: Colors.deepPurple,
                      onTap: () async {
                        final Uri launchUri = Uri(scheme: 'tel', path: '100');

                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the error, e.g., show a snackbar if the device has no dialer
                          debugPrint('Could not launch $launchUri');
                        }
                      },
                    ),
                    MenuTile(
                      icon: Icons.warning,
                      label: 'Fire',
                      secondLabel: '101',
                      iconColor: Colors.deepPurple,
                      onTap: () async {
                        final Uri launchUri = Uri(scheme: 'tel', path: '101');

                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the error, e.g., show a snackbar if the device has no dialer
                          debugPrint('Could not launch $launchUri');
                        }
                      },
                    ),
                    MenuTile(
                      icon: Icons.add_alert,
                      label: 'National Emergency',
                      secondLabel: '112',
                      iconColor: Colors.deepPurple,
                      onTap: () async {
                        final Uri launchUri = Uri(scheme: 'tel', path: '112');

                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the error, e.g., show a snackbar if the device has no dialer
                          debugPrint('Could not launch $launchUri');
                        }
                      },
                    ),
                    MenuTile(
                      icon: Icons.add_alert,
                      label: 'Women Helpline',
                      secondLabel: '1091 / 181',
                      iconColor: Colors.deepPurple,
                      onTap: () async {
                        final Uri launchUri = Uri(scheme: 'tel', path: '181');

                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the error, e.g., show a snackbar if the device has no dialer
                          debugPrint('Could not launch $launchUri');
                        }
                      },
                    ),
                    MenuTile(
                      icon: Icons.warning,
                      label: 'Disaster Management',
                      secondLabel: '109',
                      iconColor: Colors.deepPurple,
                      onTap: () async {
                        final Uri launchUri = Uri(scheme: 'tel', path: '109');

                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the error, e.g., show a snackbar if the device has no dialer
                          debugPrint('Could not launch $launchUri');
                        }
                      },
                    ),
                    MenuTile(
                      icon: Icons.add_alert,
                      label: 'National Highways',
                      secondLabel: '1033',
                      iconColor: Colors.deepPurple,
                      onTap: () async {
                        final Uri launchUri = Uri(scheme: 'tel', path: '1033');

                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the error, e.g., show a snackbar if the device has no dialer
                          debugPrint('Could not launch $launchUri');
                        }
                      },
                    ),
                    MenuTile(
                      icon: Icons.add_alert,
                      label: 'Anti-poison',
                      secondLabel: '1069',
                      iconColor: Colors.deepPurple,
                      onTap: () async {
                        final Uri launchUri = Uri(scheme: 'tel', path: '1069');

                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the error, e.g., show a snackbar if the device has no dialer
                          debugPrint('Could not launch $launchUri');
                        }
                      },
                    ),
                    MenuTile(
                      icon: Icons.add_alert,
                      label: 'Road Accident',
                      secondLabel: '1073',
                      iconColor: Colors.deepPurple,
                      onTap: () async {
                        final Uri launchUri = Uri(scheme: 'tel', path: '1073');

                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the error, e.g., show a snackbar if the device has no dialer
                          debugPrint('Could not launch $launchUri');
                        }
                      },
                    ),
                    MenuTile(
                      icon: Icons.warning,
                      label: 'Child Abuse Hotline',
                      secondLabel: '1098',
                      iconColor: Colors.deepPurple,
                      onTap: () async {
                        final Uri launchUri = Uri(scheme: 'tel', path: '1098');

                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the error, e.g., show a snackbar if the device has no dialer
                          debugPrint('Could not launch $launchUri');
                        }
                      },
                    ),
                    MenuTile(
                      icon: Icons.add_alert,
                      label: 'Tourist Helpline',
                      secondLabel: '1363',
                      iconColor: Colors.deepPurple,
                      onTap: () async {
                        final Uri launchUri = Uri(scheme: 'tel', path: '1363');

                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the error, e.g., show a snackbar if the device has no dialer
                          debugPrint('Could not launch $launchUri');
                        }
                      },
                    ),
                    MenuTile(
                      icon: Icons.warning,
                      label: 'Senior Citizen Helpline',
                      secondLabel: '1091 / 1291',
                      iconColor: Colors.deepPurple,
                      onTap: () async {
                        final Uri launchUri = Uri(scheme: 'tel', path: '1091');

                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the error, e.g., show a snackbar if the device has no dialer
                          debugPrint('Could not launch $launchUri');
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
