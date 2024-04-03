import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      colorScheme: const ColorScheme.light(
          primary: Color(0xFFE31837),
          secondary: Color(0xFFC01630)
        // all fields should have a value
      ),
      textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Color(0xFF4D4D4D), // Custom text color for AppBar title
            fontSize: 16, // Custom font size
            fontWeight: FontWeight.w600,
          ),
          headlineSmall: TextStyle( // Custom text color for AppBar title
            fontSize: 18, // Custom font size
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFF4D4D4D), // Custom text color for AppBar title
            fontSize: 14, // Custom font size
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            color: Color(0xFF4D4D4D), // Custom text color for AppBar title
            fontSize: 12, // Custom font size
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
            color: Color(0xFF4D4D4D), // Custom text color for AppBar title
            fontSize: 20,
          ),
          displaySmall:  TextStyle(
            color: Color(0xFFC01630), // Custom text color for AppBar title
            fontSize: 12,
          ),
          displayMedium: TextStyle(
            color: Colors.white, // Custom text color for AppBar title
            fontSize: 14,
            fontWeight: FontWeight.w500,
          )
      )
  );
}
