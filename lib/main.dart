import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/Data/Repositories/StoreCubit.dart';

import 'Data/Datasource/Storage/StorageRepositoryImpl.dart';
import 'Utils/AppStrings.dart';
import 'Presentation/Screens/MyHomePage.dart';
import 'config/AppTheme.dart';

void main() {

  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit(StorageRepositoryImpl()),
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: const MyHomePage(title: AppStrings.appName),
      ),

    );
  }
}

