import 'package:flutter/material.dart';
import 'package:my_app/Interactor/SaveMpinUseCase.dart';
import 'package:my_app/Interactor/ValidateMpinUseCase.dart';
import 'package:provider/provider.dart';

import '../Constants/AppStrings.dart';
import '../Repository/MpinRepositoryImpl.dart';
import '../widgets/MpinWidget.dart';
import '../widgets/PoliciesWidget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final mpinRepository = Provider.of<MpinRepositoryImpl>(context);
    final validateMpinUseCase = ValidateMpinUseCase(mpinRepository);
    final saveMpinUseCase = SaveMpinUseCase(mpinRepository);
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(title),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2.0), // Adjust the height as needed
          child: Divider(
            height: 2.0, // Adjust the height to match preferredSize
            color: theme.colorScheme.primary, // Set the color of the underline
            thickness: 2.0, // Set the thickness of the underline
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
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
                    isError: mpinRepository.isMPinError,
                    obscureText: true,
                    onCompleted: (String value) { validateMpinUseCase.setMPIN(value); },
                    errorMessage: mpinRepository.error,
                    value: mpinRepository.mpin),
                MpinWidget(title: AppStrings.confirmPinPlaceholder,
                    isError: mpinRepository.isConfirmPinError,
                    obscureText: false,
                    onCompleted: (String value) { validateMpinUseCase.setConfirmMPIN(value); },
                    errorMessage: mpinRepository.confirmMpinError,
                    value: mpinRepository.confirmMpin),
                PoliciesWidget(list: AppStrings.policies, title: AppStrings.title),
                SizedBox(height: 25),
                getButton(context,
                    mpinRepository.isButtonDisable, (){

                      saveMpinUseCase.saveMPIN(mpinRepository.mpin);
                    })
              ],
            ),
          ),
        ),
      )
    );
  }

  ElevatedButton getButton(BuildContext context, bool isDisable, void Function() onPressed){
    return ElevatedButton(
      onPressed: () {
        if(isDisable == false){
          onPressed();
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(isDisable ? Colors.grey : Theme.of(context).colorScheme.primary), // Set background color
        minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 40)), // Set button height
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0), // Set corner radius
          ),
        ),
      ),
      child: Text(
        AppStrings.buttonTitle,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}