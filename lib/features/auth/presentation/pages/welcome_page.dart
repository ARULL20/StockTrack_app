import 'package:flutter/material.dart';
import '../../../../core/widgets/welcome_background.dart';
import '../widgets/welcome_content.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeBackground(
        child: WelcomeContent(),
      ),
    );
  }
}