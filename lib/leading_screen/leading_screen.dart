
import 'package:citizen_107/common/costom_button.dart';
import 'package:citizen_107/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class LeadingScreen extends StatelessWidget {
  const LeadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Container(
            margin: EdgeInsets.only(left: 25),
            alignment: Alignment.centerLeft,
            child: Text(
              'Welcome to',
              style: TextStyle(fontSize: 33, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            alignment: Alignment.centerLeft,
            child: Text(
              'CITIZEN-107',
              style: TextStyle(fontSize: 43, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: size.height / 100),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/LOGO_ORIGINAL_02.webp',
              height: 340,
              width: size.width,
            ),
          ),
          SizedBox(height: size.height / 50),
          const SizedBox(height: 5),
          SizedBox(
            width: size.width * 0.75,
            child: CostomButton(
              text: 'CONTINUE',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              ' Privacy Policy ',
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
