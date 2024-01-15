
import 'package:shared_preferences/shared_preferences.dart';

class Common{
  static String token ='token';
  static String email = 'email';

  static setAccessToken(accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Common.token, accessToken);
  }
}