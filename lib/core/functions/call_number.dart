import 'package:url_launcher/url_launcher.dart';

Future<void> callNumber(String phoneNumber) async {
  final Uri url = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}