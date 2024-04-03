import 'package:my_app/Presentation/cubits/Base/BaseCubit.dart';
import 'package:my_app/Presentation/cubits/States/ValidateMpinState.dart';
import 'package:my_app/Utils/AppStrings.dart';
import 'package:my_app/Data/Datasource/Storage/StorageRepositoryImpl.dart';

import '../../Domain/Models/Mpins.dart';


class StoreCubit extends BaseCubit<ValidateMpinState> {
  String _mpin = '';
  String _confirmMpin = '';
  String _error = '';
  String _confirmMpinError = '';
  bool _isMPinError = false;
  bool _isConfirmPinError = false;
  bool _isButtonDisable = true;

  StoreCubit(this._storageRepositoryImpl) : super(const ValidateMpinStateSuccess("", "", "", "", false, false, true));

  String get mpin => _mpin;
  String get confirmMpin => _confirmMpin;
  String get error => _error;
  String get confirmMpinError => _confirmMpinError;
  bool get isMPinError => _isMPinError;
  bool get isConfirmPinError => _isConfirmPinError;
  bool get isButtonDisable => _isButtonDisable;
  final StorageRepositoryImpl _storageRepositoryImpl;

  void setMPIN(String value) {
    print(value);
    _mpin = value;
    _validateMPIN();
    _validateConfirmMPIN();
    validateForDuplicate(value);
    _isButtonDisable = _mpin.length < 4 ? true : _isMPinError || _isConfirmPinError;
    emit(ValidateMpinStateSuccess(_mpin,
        _confirmMpin,
        _error,
        _confirmMpinError,
        _isMPinError,
        _isConfirmPinError,
        _isButtonDisable));
  }

  void setConfirmMPIN(String value) {
    _confirmMpin = value;
    _validateConfirmMPIN();
    _isButtonDisable = _confirmMpin.length < 4 ? true : _isMPinError || _isConfirmPinError;
    emit(ValidateMpinStateSuccess(_mpin,
        _confirmMpin,
        _error,
        _confirmMpinError,
        _isMPinError,
        _isConfirmPinError,
        _isButtonDisable));
  }

  void validateForDuplicate(String value) async {
    var pins = await _storageRepositoryImpl.loadPins();
    pins.sort((a, b) => b.time.compareTo(a.time));
    List<Mpin> recentPins = pins.take(3).toList();
    Mpin? pinWithValue = recentPins.firstWhere((pin) => pin.pin == value, orElse: (){
      return Mpin(time: DateTime.now(), pin: "");
    });
    if(pinWithValue.pin.isEmpty == false){
      _error = AppStrings.pinErrorMessage;
      _isMPinError = true;
      emit(ValidateMpinStateSuccess(_mpin,
          _confirmMpin,
          _error,
          _confirmMpinError,
          _isMPinError,
          _isConfirmPinError,
          _isButtonDisable));
    }
  }

  void saveMpin(String value) async {
    var mpin = Mpin(time: DateTime.now(), pin: value);
    _storageRepositoryImpl.savePin(mpin)
        .then((value) {
      print("Saving");
      _mpin = "";
      _confirmMpin = "";
      emit(SaveMpinStateSuccess(_mpin,
          _confirmMpin,
          _error,
          _confirmMpinError,
          _isMPinError,
          _isConfirmPinError,
          _isButtonDisable));
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
