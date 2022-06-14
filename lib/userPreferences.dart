import 'package:shared_preferences/shared_preferences.dart';

class userPreferences {
  static SharedPreferences? _preferences;
  static Future init() async => _preferences=await SharedPreferences.getInstance();
  static Future setUser(String user) async => await _preferences!.setString('login', user);
  static String? getUser() => _preferences!.getString('login');
}