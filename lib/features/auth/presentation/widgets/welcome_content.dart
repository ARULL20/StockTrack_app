import 'package:flutter/material.dart';
import '../../../../core/widgets/welcome_logo.dart';
import '../../../../core/widgets/welcome_title.dart';
import '../../../../core/widgets/welcome_button.dart';
import '../../../../core/widgets/welcome_footer.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo
        const WelcomeLogo(),
        const SizedBox(height: 40),
        
        // Title and Subtitle
        const WelcomeTitle(
          title: 'Selamat Datang di StokTrackApp',
          subtitle: 'Kelola stok barang dengan mudah dan efisien',
        ),
        const SizedBox(height: 60),
        
        // Login Button
        WelcomeButton(
          text: 'Login',
          icon: Icons.login,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          },
        ),
        const SizedBox(height: 20),
        
        // Register Button
        WelcomeButton(
          text: 'Register',
          icon: Icons.person_add,
          isOutlined: true,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RegisterPage()),
            );
          },
        ),
        const SizedBox(height: 40),
        
        // Footer
        const WelcomeFooter(
          text: 'Mulai perjalanan Anda bersama kami',
        ),
      ],
    );
  }
}