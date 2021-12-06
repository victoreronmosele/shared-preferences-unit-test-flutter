import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  SharedPreferencesUtil({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @visibleForTesting
  static const String countKey = 'counter';

  int getCount() {
    return sharedPreferences.getInt(countKey) ?? 0;
  }

  Future<bool> setCount(int count) async {
    return sharedPreferences.setInt(countKey, count);
  }
}
