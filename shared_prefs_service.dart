import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String _keyLastResult = 'last_result';

  static Future<void> saveLastResult(String result) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLastResult, result);
  }

  static Future<String?> getLastResult() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLastResult);
  }
}

