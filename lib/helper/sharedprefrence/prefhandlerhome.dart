import 'package:shared_preferences/shared_preferences.dart';

class PrefHandler {
  // SharedPreferences instance
  static late SharedPreferences prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Save data to SharedPreferences
  static Future<void> save(String key, dynamic value) async {
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  // Retrieve data from SharedPreferences
  static dynamic get(String key) {
    return prefs.get(key);
  }

  // Remove data from SharedPreferences
  static Future<void> remove(String key) async {
    await prefs.remove(key);
  }

  // Clear all SharedPreferences data
  static Future<void> clear() async {
    await prefs.clear();
  }
}
