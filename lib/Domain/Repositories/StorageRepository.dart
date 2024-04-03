import '../Models/Mpins.dart';

abstract class StorageRepository {
  Future<void> savePin(Mpin pin);
}