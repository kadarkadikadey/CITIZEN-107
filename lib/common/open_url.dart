import 'package:url_launcher/url_launcher.dart';

Future<void> openExternalLink(String urlString) async {
  // 1. Handle missing http/https prefixes
  String formattedUrl = urlString.startsWith('http') 
      ? urlString 
      : 'https://$urlString';

  final Uri url = Uri.parse(formattedUrl);

 
  if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // Forces it to open in Chrome/Safari
    );
  } else {
    throw 'Could not launch $formattedUrl';
  }
}