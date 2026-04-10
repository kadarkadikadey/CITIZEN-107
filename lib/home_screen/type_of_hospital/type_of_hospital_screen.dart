
import 'package:citizen_107/common/menutile.dart';
import 'package:citizen_107/common/open_url.dart';
import 'package:flutter/material.dart';
import 'package:health_icons/health_icons.dart';


class TypeOfHospitalScreen extends StatelessWidget {
  const TypeOfHospitalScreen({super.key});

  final String linktoCARDIOLOGY = 'https://maps.app.goo.gl/YXiUXhViZqCFJDbKA';
  
  final String  linktoCHILDRENHOSPITAL ='https://maps.app.goo.gl/A4JKN6DVdbK2vGDr6';
  
  final String  linktoONCOLOGY ='https://maps.app.goo.gl/s8k6mBBpyE6ctPFk8';
  
  final String  linktoNECROLOGY ='https://maps.app.goo.gl/3dteh3zsakPbFZ7XA';
  
  final String  linktoORTHOPEDIC ='https://maps.app.goo.gl/qNxbXasZsrvBT9pb9';
  
  final String  linktoGASTROENTHTEROLY ='https://maps.app.goo.gl/KWXpKLTN81J92Sq37';
  
  final String  linktoPULMONOLOGY ='https://maps.app.goo.gl/HQ5ejUMsniRJn6aKA';
  
  final String  linktoOPNTHALOMOLOAY ='https://maps.app.goo.gl/tanc3izwbckwY2F7A';
  
  final String  linktoDERMATOLOGY ='https://maps.app.goo.gl/Eq793cyMdayyL9kj8';

  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Types of hospitals besed on disease',
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
                      icon: HealthIcons.heartFilled,
                      label: 'CARDIOLOGY',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        openExternalLink(linktoCARDIOLOGY);
                      },
                    ),
                    MenuTile(
                      icon: HealthIcons.oncologyFilled,
                      label: 'ONCOLOGY',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        openExternalLink(linktoONCOLOGY);
                      },
                    ),
                    MenuTile(
                      icon: Icons.pin_drop,
                      label: 'NECROLOGY',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        openExternalLink(linktoNECROLOGY);
                      },
                    ),
                    MenuTile(
                      icon: HealthIcons.orthopaedicsFilled,
                      label: 'ORTHOPEDIC',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        openExternalLink(linktoORTHOPEDIC);
                      },
                    ),
                    MenuTile(
                      icon: HealthIcons.gastroenterologyFilled,
                      label: 'GASTROENTHTEROLY',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        openExternalLink(linktoGASTROENTHTEROLY);
                      },
                    ),
                    MenuTile(
                      icon: HealthIcons.nephrologyFilled,
                      label: 'NEPHROLOGY',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        openExternalLink(linktoNECROLOGY);
                      },
                    ),
                    MenuTile(
                      icon: HealthIcons.lungsFilled, // Closest stock icon for caregivers
                      label: 'PULMONOLOGY',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        openExternalLink(linktoPULMONOLOGY);
                      },
                    ),
                    MenuTile(
                      icon: HealthIcons.opthalmologyFilled,
                      label: 'OPNTHALOMOLOAY',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        openExternalLink(linktoOPNTHALOMOLOAY);
                      },
                    ),
                    MenuTile(
                      icon: HealthIcons.skinCancerFilled,
                      label: 'DERMATOLOGY',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        openExternalLink(linktoDERMATOLOGY);
                      },
                    ),
                    MenuTile(
                      icon: HealthIcons.childCareFilled,
                      label: 'CHILDREN HOSPITAL',
                      secondLabel: '',
                      iconColor: Colors.deepPurple,
                      onTap: () {
                        openExternalLink(linktoCHILDRENHOSPITAL);
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
