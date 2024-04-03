import 'package:bloc/bloc.dart';

abstract class BaseCubit<S> extends Cubit<S>{
  BaseCubit(super.initialState);
}