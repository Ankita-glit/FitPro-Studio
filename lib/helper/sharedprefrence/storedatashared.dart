import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/auth/loginsignup/login/loginmodel.dart';

Future<void> saveUserData(Loginmodel loginModel) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('user_name', loginModel.name ?? '');
  prefs.setString('user_email', loginModel.email ?? '');
  prefs.setInt('user_height', loginModel.height??0);
  prefs.setDouble('user_weight', loginModel.weight??0);
  prefs.setString('user_gender', loginModel.gender??'Male');
  prefs.setString('user_heightunit',loginModel.hunit??'');
}
