import 'dart:convert';
import 'package:my_app/Data/Datasource/Storage/Base/BaseStorageRepository.dart';
import 'package:my_app/Domain/Repositories/StorageRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Domain/Models/Mpins.dart';

class StorageRepositoryImpl extends BaseStorageRepository implements StorageRepository {
  Future<void> savePin(Mpin pin) async {
    List<Mpin> loadedMpins = await loadPins();
    loadedMpins.add(pin);
    List<Map<String, dynamic>> mpinJsonList = loadedMpins.map((pin) => pin.toJson()).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mpinList', jsonEncode(mpinJsonList));
  }

}