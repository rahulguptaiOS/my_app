import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Domain/Models/Mpins.dart';

abstract class BaseStorageRepository {
  @protected
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