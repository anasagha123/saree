// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences instance;
  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();
}


class SharedPreferencesKeys{
  static const LOCALE = "locale";
  static const USER_TOKEN = "userToken";
  static const SELECTED_LOCATION_ID = "selected location id";
}