import 'package:citizen_107/common/menutile.dart';
import 'package:citizen_107/home_screen/help_me_screens/help_me_location_screen.dart';  
import 'package:flutter/material.dart';

class HelpMeOptionScreen extends StatelessWidget {
  const HelpMeOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Emergency Help Available 24/7',
          style: TextStyle(fontSize: 16),
        ),
      ),
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
                      icon: Icons.pin_drop,
                      label: 'INGERY',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpMeLocationScreen(typeOfIngery: 'INGERY',),
                          ),
                        );
                      },
                    ),
                    MenuTile(
                      icon: Icons.pin_drop,
                      label: 'HEATSTROKE',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpMeLocationScreen(typeOfIngery: 'HEATSTROKE',),
                          ),
                        );
                      },
                    ),
                    MenuTile(
                      icon: Icons.pin_drop,
                      label: 'BURN',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpMeLocationScreen(typeOfIngery: 'BURN',),
                          ),
                        );
                      },
                    ),
                    MenuTile(
                      icon: Icons.pin_drop,
                      label: 'ASTHMA ATTACK',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpMeLocationScreen(typeOfIngery: 'ASTHMA ATTACK',),
                          ),
                        );
                      },
                    ),
                    MenuTile(
                      icon: Icons.pin_drop,
                      label: 'LABOUR PAIN',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpMeLocationScreen(typeOfIngery: 'LABOUR PAIN',),
                          ),
                        );
                      },
                    ),
                    MenuTile(
                      icon: Icons.pin_drop,
                      label: 'ANIMAL BITE',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpMeLocationScreen(typeOfIngery:  'ANIMAL BITE',),
                          ),
                        );
                      },
                    ),
                    MenuTile(
                      icon: Icons.pin_drop, // Closest stock icon for caregivers
                      label: 'BLEEDING',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpMeLocationScreen(typeOfIngery: 'BLEEDING',),
                          ),
                        );
                      },
                    ),
                    MenuTile(
                      icon: Icons.pin_drop,
                      label: 'OTHER',
                      secondLabel: '',
                      iconColor: Colors.grey.shade600,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpMeLocationScreen(typeOfIngery: 'OTHER',),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
