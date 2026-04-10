
import 'package:citizen_107/common/costom_button.dart';
import 'package:citizen_107/common/open_url.dart';
import 'package:flutter/material.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  final String linktoUrl = 'https://www.google.com/maps/search/medical+store+near+me/@22.5730239,72.9228225,13z/data=!3m1!4b1?entry=ttu&g_ep=EgoyMDI2MDQwMS4wIKXMDSoASAFQAw%3D%3D';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('citizen 107')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Pharmacy Store Location Nearby...', style: TextStyle(fontWeight: FontWeight.bold),)),
                SizedBox(height: 50),
                CostomButton(
                  text: 'Open Map For Pharmacy Store', 
                  onPressed:  (){
                     openExternalLink(linktoUrl);
                  }
                  )
              ],
            ),
          ),
        ),
      ),
    );  
  }
}
