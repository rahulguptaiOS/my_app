import 'package:my_app/Repository/MpinRepositoryImpl.dart';

class ValidateMpinUseCase {
  final MpinRepositoryImpl repository;

  ValidateMpinUseCase(this.repository);

  void setMPIN(String value){
    repository.setMPIN(value);
  }

  void setConfirmMPIN(String value){
    repository.setConfirmMPIN(value);
  }
}