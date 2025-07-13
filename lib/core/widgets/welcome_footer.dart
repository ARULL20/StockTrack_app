import 'package:flutter/material.dart';
import '../theme/welcome_theme.dart';

class WelcomeFooter extends StatelessWidget {
  final String text;

  const WelcomeFooter({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: WelcomeTheme.footerStyle,
      textAlign: TextAlign.center,
    );
  }
}