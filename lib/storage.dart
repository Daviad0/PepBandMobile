import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

class StorageInfo{
  static SharedPreferences? prefs;
}

void initialize() async {
  StorageInfo.prefs = await SharedPreferences.getInstance();
}

SharedPreferences getPreferences() {
  // ! after the variable makes it non-nullable
  return StorageInfo.prefs!;
}

