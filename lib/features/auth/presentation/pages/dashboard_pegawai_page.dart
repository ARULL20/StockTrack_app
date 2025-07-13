import 'package:flutter/material.dart';
import 'package:stoktrack_app/features/auth/presentation/pages/login_page.dart';
import 'package:stoktrack_app/features/barang_keluar/presentation/pages/barang_keluar_page.dart';
import 'package:stoktrack_app/features/kategori_barang/presentation/pages/kategori_barang_page.dart';
import 'package:stoktrack_app/features/gudang/presentation/pages/gudang_page.dart';
import 'package:stoktrack_app/features/barang/presentation/pages/barang_page.dart';
import 'package:stoktrack_app/features/kategori_makanan/presentation/pages/kategori_makanan_page.dart';
import 'package:stoktrack_app/features/kategori_minuman/presentation/pages/kategori_minuman_page.dart';
import 'package:stoktrack_app/features/makanan/presentation/pages/makanan_page.dart';
import 'package:stoktrack_app/features/minuman/presentation/pages/minuman_page.dart';

// Import your clean architecture components
import '../widgets/dashboard_app_bar.dart';
import '../widgets/welcome_header.dart';
import '../widgets/menu_grid.dart';
import '../../domain/usecases/dashboard_usecase.dart';
import '../../data/repositories/menu_repository_impl.dart';

class DashboardPegawaiPage extends StatefulWidget {
  const DashboardPegawaiPage({super.key});

  @override
  State<DashboardPegawaiPage> createState() => _DashboardPegawaiPageState();
}

class _DashboardPegawaiPageState extends State<DashboardPegawaiPage> {
  late final DashboardUseCase _dashboardUseCase;

  @override
  void initState() {
    super.initState();
    _dashboardUseCase = DashboardUseCase(
      menuRepository: MenuRepositoryImpl(),
    );
  }

  Future<void> _logout() async {
    await _dashboardUseCase.logout(context);
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  void _navigateToPage(String route) {
    Widget page;
    
    switch (route) {
      case '/kategori-barang':
        page = const KategoriBarangPage();
        break;
      case '/gudang':
        page = const GudangPage();
        break;
      case '/barang':
        page = const BarangPage();
        break;
      case '/kategori-makanan':
        page = const KategoriMakananPage();
        break;
      case '/kategori-minuman':
        page = const KategoriMinumanPage();
        break;
      case '/makanan':
        page = const MakananPage();
        break;
      case '/minuman':
        page = const MinumanPage();
        break;
      case '/barang-keluar':
        page = const BarangKeluarPage();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = _dashboardUseCase.getMenuItems();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: DashboardAppBar(onLogout: _logout),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeHeader(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Menu Utama',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            MenuGrid(
              menuItems: menuItems,
              onMenuTap: _navigateToPage,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}