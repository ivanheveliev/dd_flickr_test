import 'package:url_launcher/url_launcher.dart';

class AppMethods {
  launchURL(String link) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link));
    }
  }
}
