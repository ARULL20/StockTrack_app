import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/widgets/admin_header.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/dashboard_grid.dart';
import 'login_page.dart';

class DashboardAdminPage extends StatelessWidget {
  const DashboardAdminPage({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.theme,
      child: Scaffold(
        backgroundColor: AppTheme.greyLight,
        body: Column(
          children: [
            AdminHeader(
              adminName: 'Admin',
              onLogout: () => _logout(context),
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: DashboardGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}