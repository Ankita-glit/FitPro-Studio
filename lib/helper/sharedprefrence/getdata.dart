import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/auth/loginsignup/login/loginmodel.dart';

Future<Loginmodel> getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? userName = prefs.getString('user_name');
  String? userEmail = prefs.getString('user_email');

  if (userName != null && userEmail != null) {
    return Loginmodel(name: userName, email: userEmail);
  } else {
    return Loginmodel();
  }
}
