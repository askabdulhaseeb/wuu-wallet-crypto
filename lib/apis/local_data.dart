import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static late SharedPreferences _preferences;
  static Future<SharedPreferences> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static signout() => _preferences.clear();

  static const String _privateKey = 'PrivateKey';
  static const String _privateKeyAddress = 'PrivateKeyAddress';
  static const String _emailKey = 'EmailKey';
  static const String _passwordKey = 'PasswordKey';

  static Future<void> setPrivateKey(String value) async =>
      await _preferences.setString(_privateKey, value);
  static Future<void> setPrivateKeyAddress(String value) async =>
      await _preferences.setString(_privateKeyAddress, value);
  static Future<void> setEmailKey(String value) async =>
      await _preferences.setString(_emailKey, value);
  static Future<void> setPasswordKey(String value) async =>
      await _preferences.setString(_passwordKey, value);

  static String? privateKey() => _preferences.getString(_privateKey);
  static String? privateKeyAddress() =>
      _preferences.getString(_privateKeyAddress);
  static String? email() => _preferences.getString(_emailKey);
  static String? password() => _preferences.getString(_passwordKey);
}
