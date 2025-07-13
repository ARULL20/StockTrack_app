import 'package:flutter/material.dart';
import '../theme/welcome_theme.dart';

class WelcomeTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const WelcomeTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: WelcomeTheme.transparentWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: WelcomeTheme.semiTransparentWhite,
              width: 1,
            ),
          ),
          child: Text(
            title,
            style: WelcomeTheme.titleStyle,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          style: WelcomeTheme.subtitleStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}