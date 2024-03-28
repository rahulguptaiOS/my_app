import 'dart:convert';

import 'package:my_app/Entity/Mpins.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  Future<void> savePin(Mpin pin) async {
    List<Mpin> loadedMpins = await loadPins();
    loadedMpins.add(pin);
    List<Map<String, dynamic>> mpinJsonList = loadedMpins.map((pin) => pin.toJson()).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mpinList', jsonEncode(mpinJsonList));
  }

  Future<List<Mpin>> loadPins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userListJson = prefs.getString('mpinList');
    if (userListJson != null) {
      List<dynamic> userJsonList = jsonDecode(userListJson);
      return userJsonList.map((json) => Mpin.fromJson(json)).toList();
    } else {
      return [];
    }
  }

}