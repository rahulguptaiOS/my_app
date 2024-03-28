import 'package:flutter/material.dart';
import 'package:my_app/Constants/AppStrings.dart';
import 'package:my_app/Entity/Mpins.dart';
import 'package:my_app/Storage/PreferenceManager.dart';


class MpinRepositoryImpl extends ChangeNotifier {
  String _mpin = '';
  String _confirmMpin = '';
  String _error = '';
  String _confirmMpinError = '';
  bool _isMPinError = false;
  bool _isConfirmPinError = false;
  bool _isButtonDisable = true;

  String get mpin => _mpin;
  String get confirmMpin => _confirmMpin;
  String get error => _error;
  String get confirmMpinError => _confirmMpinError;
  bool get isMPinError => _isMPinError;
  bool get isConfirmPinError => _isConfirmPinError;
  bool get isButtonDisable => _isButtonDisable;
  late PreferenceManager preferenceManager = PreferenceManager();

  void setMPIN(String value) {
    print(value);
    _mpin = value;
    _validateMPIN();
    _validateConfirmMPIN();
    validateForDuplicate(value);
    _isButtonDisable = _mpin.length < 4 ? true : _isMPinError || _isConfirmPinError;
    notifyListeners();
  }

  void setConfirmMPIN(String value) {
    _confirmMpin = value;
    _validateConfirmMPIN();
    _isButtonDisable = _confirmMpin.length < 4 ? true : _isMPinError || _isConfirmPinError;
    notifyListeners();
  }

  void validateForDuplicate(String value) async {
    var pins = await preferenceManager.loadPins();
    pins.sort((a, b) => b.time.compareTo(a.time));
    List<Mpin> recentPins = pins.take(3).toList();
    Mpin? pinWithValue = recentPins.firstWhere((pin) => pin.pin == value, orElse: (){
      return Mpin(time: DateTime.now(), pin: "");
    });
    if(pinWithValue.pin.isEmpty == false){
      _error = AppStrings.pinErrorMessage;
      _isMPinError = true;
      notifyListeners();
    }
  }

  void saveMpin(String value) async {
    var mpin = Mpin(time: DateTime.now(), pin: value);
    preferenceManager.savePin(mpin)
        .then((value) {
      print("Saving");
      _mpin = "";
      _confirmMpin = "";
      notifyListeners();
    });
  }

  void _validateMPIN() {
    _error = '';
    _isMPinError = false;
    if (_mpin.length >= 3) {
      if (_hasConsecutiveNumbers() || _hasRepeatedNumbers()) {
        _error = _hasConsecutiveNumbers() ? AppStrings.policies[2] : AppStrings.policies[1];
        _isMPinError = true;
      }
    }
  }

  void _validateConfirmMPIN() {
    _confirmMpinError = '';
    _isConfirmPinError = false;
    if (_mpin != _confirmMpin) {
      _confirmMpinError = AppStrings.confirmErrorMessage;
      _isConfirmPinError = true;
    }
  }

  bool _hasConsecutiveNumbers() {
    for (int i = 0; i < _mpin.length - 1; i++) {
      if (_mpin.codeUnitAt(i) == _mpin.codeUnitAt(i + 1) - 1) {
        return true;
      }
    }
    return false;
  }

  bool _hasRepeatedNumbers() {
    for (int i = 0; i < _mpin.length - 2; i++) {
      if (_mpin[i] == _mpin[i + 1] && _mpin[i + 1] == _mpin[i + 2]) {
        return true;
      }
    }
    return false;
  }

}
