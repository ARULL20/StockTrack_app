import 'package:flutter/material.dart';

class WelcomeTheme {
  // Gradient Colors
  static const List<Color> backgroundGradient = [
    Color(0xFF1B5E20),
    Color(0xFF2E7D32),
    Color(0xFF4CAF50),
    Color(0xFF81C784),
  ];

  // Primary Colors
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color darkGreen = Color(0xFF1B5E20);
  static const Color lightGreen = Color(0xFF4CAF50);
  static const Color accentGreen = Color(0xFF81C784);
  
  // Supporting Colors
  static const Color white = Colors.white;
  static const Color transparentWhite = Color(0x1AFFFFFF);
  static const Color semiTransparentWhite = Color(0x33FFFFFF);
  static const Color shadowColor = Color(0x1A000000);
  static const Color textShadow = Color(0x42000000);

  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    color: white,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    shadows: [
      Shadow(
        offset: Offset(2, 2),
        blurRadius: 4,
        color: textShadow,
      ),
    ],
  );

  static TextStyle subtitleStyle = TextStyle(
    color: white.withOpacity(0.9),
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static TextStyle footerStyle = TextStyle(
    color: white.withOpacity(0.7),
    fontSize: 14,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
}