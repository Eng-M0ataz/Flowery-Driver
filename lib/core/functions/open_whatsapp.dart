import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsApp(String phoneNumber, {String message = ''}) async {
  final Uri whatsappUri = Uri.parse(
    'whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}',
  );

  if (await canLaunchUrl(whatsappUri)) {
    await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
  } else {
    final Uri fallbackUrl = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );
    await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
  }
}
