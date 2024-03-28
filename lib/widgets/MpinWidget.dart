import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MpinWidget extends StatelessWidget {
  String _title = "";
  String _errorMessage = "";
  bool _isError = false;
  bool _obscureText = false;
  ValueChanged<String> _onCompleted = (value){};
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  MpinWidget({super.key, required String title, required String value, required String errorMessage, required bool isError, required bool obscureText, required ValueChanged<String> onCompleted}) {
    _title = title;
    _isError = isError;
    _obscureText = obscureText;
    _onCompleted = onCompleted;
    _errorMessage = errorMessage;
    controllers = List.generate(4, (index) {
      var controller = TextEditingController();
      if(index < value.length){
        controller.text = value[index];
      }

      return controller;
    });
    focusNodes = List.generate(4, (index) => FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Text(_title),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              return getPintText(context,
                  _isError,
                  controllers[index],
                  focusNodes[index],
                  (value){
                    if (value.isNotEmpty) {
                      if (index < 3) {
                        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                      } else {
                        FocusScope.of(context).unfocus();
                        String code = controllers.map((e) => e.text).join();
                        _onCompleted(code);
                      }
                    } else if(index > 0) {
                      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                    }
                  },
                  (){
                    if (index > 0) {
                      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                      if(index == 3){
                        FocusScope.of(context).unfocus();
                      }
                    }
                  }
              );
            })
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: SizedBox(
              height: 15,
              child: Visibility(
                  visible: _isError,
                  child: getErrorWidget(context, _errorMessage)
              ),
            ),
          )
        ]
    );
  }

  Widget getPintText(BuildContext context, bool isError, controller, focusNode, void Function(String)? onChanged, void Function()? onEditingComplete) {
    return Container(
      height: 50,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
        border: Border.all(
          color: isError ? Theme.of(context).colorScheme.secondary : Colors.grey, // Border color
          width: 1.0, // Border width
        ),
      ),
      child: TextField(
        obscureText: _obscureText,
        cursorColor: Colors.black,
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        onEditingComplete: onEditingComplete,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0), // Padding
          border: InputBorder.none, // Remove TextField's default border
        ),
      ),
    );
  }

  Widget getErrorWidget(BuildContext context, String title){
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Image.asset(
            'assets/alert-triangle.png',
            width: 16,
            height: 16,
          ),
        ),
        Text(title, style: Theme.of(context).textTheme.displaySmall)
      ],
    );
  }
}


