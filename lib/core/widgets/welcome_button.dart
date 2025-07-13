import 'package:flutter/material.dart';
import '../theme/welcome_theme.dart';

class WelcomeButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isOutlined;

  const WelcomeButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isOutlined
                ? WelcomeTheme.shadowColor.withOpacity(0.1)
                : WelcomeTheme.shadowColor,
            blurRadius: isOutlined ? 8 : 10,
            offset: Offset(0, isOutlined ? 2 : 4),
          ),
        ],
      ),
      child: isOutlined ? _buildOutlinedButton() : _buildElevatedButton(),
    );
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: WelcomeTheme.white,
        foregroundColor: WelcomeTheme.primaryGreen,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        shadowColor: WelcomeTheme.shadowColor.withOpacity(0.3),
      ),
      onPressed: onPressed,
      child: _buildButtonContent(),
    );
  }

  Widget _buildOutlinedButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: WelcomeTheme.white,
        side: const BorderSide(
          color: WelcomeTheme.white,
          width: 2,
        ),
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: WelcomeTheme.transparentWhite,
      ),
      onPressed: onPressed,
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(text, style: WelcomeTheme.buttonTextStyle),
      ],
    );
  }
}