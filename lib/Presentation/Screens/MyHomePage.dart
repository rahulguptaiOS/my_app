
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/Presentation/cubits/States/ValidateMpinState.dart';
import '../../Utils/AppStrings.dart';
import '../../Data/Repositories/StoreCubit.dart';
import '../widgets/MpinAppBar.dart';
import '../widgets/MpinWidget.dart';
import '../widgets/PoliciesWidget.dart';
import '../widgets/SaveButton.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final storeCubit = BlocProvider.of<StoreCubit>(context);
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: MpinAppBar(
        title: title,
        onBackPress: (){},
        onMorePress: (){},
      ),
      body: BlocBuilder<StoreCubit, ValidateMpinState>(
        builder: (_, state) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(AppStrings.setMPin,
                          style: theme.textTheme.headlineMedium),
                    ),
                    const SizedBox(height: 20),
                    MpinWidget(title: AppStrings.pinPlaceholder,
                        isError: state.isMPinError,
                        obscureText: true,
                        onCompleted: (String value) { storeCubit.setMPIN(value); },
                        errorMessage: state.error,
                        value: state.mpin),
                    MpinWidget(title: AppStrings.confirmPinPlaceholder,
                        isError: state.isConfirmPinError,
                        obscureText: false,
                        onCompleted: (String value) { storeCubit.setConfirmMPIN(value); },
                        errorMessage: state.confirmMpinError,
                        value: state.confirmMpin),
                    PoliciesWidget(list: AppStrings.policies, title: AppStrings.title),
                    const SizedBox(height: 25),
                    SaveButton(isDisabled: state.isButtonDisable,
                        onPressed: (){
                          storeCubit.saveMpin(state.mpin);
                        },
                        buttonText: AppStrings.buttonTitle)
                  ],
                ),
              ),
            ),
          );
        }
      )
    );
  }
}