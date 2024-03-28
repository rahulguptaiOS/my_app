import '../Repository/MpinRepositoryImpl.dart';

class SaveMpinUseCase {
  final MpinRepositoryImpl repository;

  SaveMpinUseCase(this.repository);

  void saveMPIN(String value){
    repository.saveMpin(value);
  }

}