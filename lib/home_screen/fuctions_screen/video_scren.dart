import 'package:citizen_107/common/open_url.dart';
import 'package:flutter/material.dart';

class VideoScren extends StatelessWidget {
  const VideoScren({super.key});

  final String linktoUrl1 = 'https://www.youtube.com/watch?v=AHEmU29Ul_s';
  final String linktoUrl2 = 'https://www.youtube.com/watch?v=2ynlaWUwMsA';
  final String linktoUrl3 =
      'https://www.youtube.com/results?search_query=how+to+do+firsted';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Citizen 107')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          InkWell(
            onTap: () {
              openExternalLink(linktoUrl1);
            },
            child: ApartmentCard(
              imageUrl:
                  'assets/images/LOGO_ORIGINAL_02.webp', // Replace with your image
              title: 'First Aid For A Cut Wound',

              details: 'First aid',
              type: 'aid',
            ),
          ),
          SizedBox(height: 16),
          InkWell(
            onTap: () {
              openExternalLink(linktoUrl2);
            },
            child: ApartmentCard(
              imageUrl:
                  'assets/images/LOGO_ORIGINAL_02.webp', // Replace with your image
              title: '10 First Aid Mistakes',

              details: 'Professional',
              type: 'Mistakes',
            ),
          ),
          SizedBox(height: 16),
          InkWell(
            onTap: () {
              openExternalLink(linktoUrl3);
            },
            child: ApartmentCard(
              imageUrl:
                  'assets/images/LOGO_ORIGINAL_02.webp', // Replace with your image
              title: 'CPR',
              details: 'CPR',
              type: 'CPR',
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class ApartmentCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  final String details;
  final String type;

  const ApartmentCard({
    super.key,
    required this.imageUrl,
    required this.title,

    required this.details,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imageUrl,
                width: 220,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // 2. Text Content Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF2D3E50),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    details,
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Text(
                        type,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
