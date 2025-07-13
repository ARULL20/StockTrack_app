import 'package:flutter/material.dart';
import '../theme/welcome_theme.dart';

class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: WelcomeTheme.transparentWhite,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: WelcomeTheme.semiTransparentWhite,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: WelcomeTheme.shadowColor,
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(
        Icons.inventory_2_rounded,
        size: 100,
        color: WelcomeTheme.white,
      ),
    );
  }
}