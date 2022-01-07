import 'dart:convert';

import 'package:americonictv_tv/data/user_data.dart';
import 'package:americonictv_tv/logic/api/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Prefs {
  static SharedPreferences _instance;
  static SharedPreferences get instance => _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
    final String userDataEncoded = _instance.getString('userData');
    if (userDataEncoded != null) {
      final Map userDataDecoded = jsonDecode(userDataEncoded);
      await User.setInstance(UserData.fromJson(userDataDecoded));
    }
  }
}
