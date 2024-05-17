import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StorageKey { lang, theme, token, pinCode }

@immutable
sealed class StorageService {
  /// store data
  static Future<void> storeData(
      {required StorageKey key, required String value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key.name, value);
  }

  /// load data
  static Future<String?> loadData({required StorageKey key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key.name)!;
  }

  /// remove data
  static Future<void> removeData({required StorageKey key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key.name);
  }
}
