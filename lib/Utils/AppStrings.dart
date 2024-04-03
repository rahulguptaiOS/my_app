class AppStrings {
  static const String appName = 'Set MPIN';
  static const String setMPin = 'Set your MPIN for further login.';
  static const String title = "Please ensure you MPIN to be as per below policies:";
  static const String pinPlaceholder = "Enter MPIN";
  static const String confirmPinPlaceholder = "Confirm MPIN";
  static const String pinErrorMessage = "MPIN should not match last 3 MPIN";
  static const String confirmErrorMessage = "MPIN & confirm MPIN doesn’t match";
  static const String buttonTitle = "Set MPIN";
  static const List<String> policies = [
    "MPIN should be 4 digits in length",
    "3 consecutive numbers cannot be the same",
    "3 consecutive numbers cannot be in sequence",
  ];
}
