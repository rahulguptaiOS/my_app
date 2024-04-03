import 'package:equatable/equatable.dart';

abstract class ValidateMpinState extends Equatable {
  final String mpin, confirmMpin, error, confirmMpinError;
  final bool isMPinError, isConfirmPinError, isButtonDisable;
  const ValidateMpinState(this.mpin, this.confirmMpin, this.error, this.confirmMpinError, this.isMPinError, this.isConfirmPinError, this.isButtonDisable);
  @override
  List<Object?> get props => [mpin, confirmMpin, error, confirmMpinError, isMPinError, isConfirmPinError, isButtonDisable];
}

class ValidateMpinStateSuccess extends ValidateMpinState {
  const ValidateMpinStateSuccess(super.mpin, super.confirmMpin, super.error, super.confirmMpinError, super.isMPinError, super.isConfirmPinError, super.isButtonDisable);
}

class SaveMpinStateSuccess extends ValidateMpinState {
  const SaveMpinStateSuccess(super.mpin, super.confirmMpin, super.error, super.confirmMpinError, super.isMPinError, super.isConfirmPinError, super.isButtonDisable);
}