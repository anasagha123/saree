import 'dart:io';

import 'package:flutter/material.dart';

import '../network/local/my_shared_preferences.dart';

class DeviceLocale{
  static late Locale locale;

  static Locale init() => locale = Locale( SharedPreferencesHelper.instance.getString(SharedPreferencesKeys.LOCALE) ?? Platform.localeName);
}