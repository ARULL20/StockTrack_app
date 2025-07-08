import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stoktrack_app/features/auth/presentation/pages/login_page.dart';
import 'package:stoktrack_app/features/kategori_barang/presentation/pages/kategori_barang_page.dart';
import 'package:stoktrack_app/features/gudang/presentation/pages/gudang_page.dart';
import 'package:stoktrack_app/features/barang/presentation/pages/barang_page.dart'; // ✅ Import BarangPage

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Selamat datang Admin!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const KategoriBarangPage(),
                  ),
                );
              },
              child: const Text('Kelola Kategori Barang'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GudangPage(),
                  ),
                );
              },
              child: const Text('Kelola Gudang'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BarangPage(),
                  ),
                );
              },
              child: const Text('Kelola Barang'),
            ),
          ],
        ),
      ),
    );
  }
}
