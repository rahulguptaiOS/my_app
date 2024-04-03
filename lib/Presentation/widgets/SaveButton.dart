import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final bool isDisabled;
  final VoidCallback onPressed;
  final String buttonText;

  const SaveButton({
    super.key,
    required this.isDisabled,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          isDisabled ? Colors.grey : Theme.of(context).colorScheme.primary,
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(double.infinity, 40),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
