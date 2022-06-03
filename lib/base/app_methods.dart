import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBaseMethods {
  static SharedPreferences? sharedPreferences;

  getPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  launchURL(String link) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link));
    }
  }

  setInfoAboutLikeInSP(bool isLike, int index) {
    sharedPreferences!.setBool('isLiked$index', isLike);
  }

  bool? getInfoAboutLikesFromSP(int index) {
    try {
      return sharedPreferences!.getBool('isLiked$index');
    } catch (e) {
      return false;
    }
  }
}
