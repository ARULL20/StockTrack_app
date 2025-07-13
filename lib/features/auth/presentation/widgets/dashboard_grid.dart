import 'package:flutter/material.dart';
import '../../../../core/widgets/dashboard_card.dart';
import '../pages/login_page.dart';
import '../../../barang_keluar/presentation/pages/barang_keluar_page.dart';
import '../../../kategori_barang/presentation/pages/kategori_barang_page.dart';
import '../../../gudang/presentation/pages/gudang_page.dart';
import '../../../barang/presentation/pages/barang_page.dart';
import '../../../kategori_makanan/presentation/pages/kategori_makanan_page.dart';
import '../../../kategori_minuman/presentation/pages/kategori_minuman_page.dart';
import '../../../makanan/presentation/pages/makanan_page.dart';
import '../../../minuman/presentation/pages/minuman_page.dart';
import '../../../laporan/presentation/pages/laporan_page.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'icon': Icons.category_outlined,
        'title': 'Kategori Barang',
        'subtitle': 'Kelola kategori barang',
        'page': const KategoriBarangPage(),
        'color': Colors.blue.shade50,
      },
      {
        'icon': Icons.warehouse_outlined,
        'title': 'Gudang',
        'subtitle': 'Kelola gudang penyimpanan',
        'page': const GudangPage(),
        'color': Colors.orange.shade50,
      },
      {
        'icon': Icons.inventory_2_outlined,
        'title': 'Barang',
        'subtitle': 'Kelola stok barang',
        'page': const BarangPage(),
        'color': Colors.purple.shade50,
      },
      {
        'icon': Icons.restaurant_outlined,
        'title': 'Kategori Makanan',
        'subtitle': 'Kelola kategori makanan',
        'page': const KategoriMakananPage(),
        'color': Colors.red.shade50,
      },
      {
        'icon': Icons.local_drink_outlined,
        'title': 'Kategori Minuman',
        'subtitle': 'Kelola kategori minuman',
        'page': const KategoriMinumanPage(),
        'color': Colors.cyan.shade50,
      },
      {
        'icon': Icons.fastfood_outlined,
        'title': 'Makanan',
        'subtitle': 'Kelola stok makanan',
        'page': const MakananPage(),
        'color': Colors.green.shade50,
      },
      {
        'icon': Icons.local_cafe_outlined,
        'title': 'Minuman',
        'subtitle': 'Kelola stok minuman',
        'page': const MinumanPage(),
        'color': Colors.indigo.shade50,
      },
      {
        'icon': Icons.output_outlined,
        'title': 'Barang Keluar',
        'subtitle': 'Kelola barang keluar',
        'page': const BarangKeluarPage(),
        'color': Colors.deepOrange.shade50,
      },
      {
        'icon': Icons.analytics_outlined,
        'title': 'Laporan',
        'subtitle': 'Lihat laporan lengkap',
        'page': const LaporanPage(),
        'color': Colors.teal.shade50,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Menu Utama',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 20),
          ...menuItems.map((item) => DashboardCard(
            icon: item['icon'] as IconData,
            title: item['title'] as String,
            subtitle: item['subtitle'] as String,
            cardColor: item['color'] as Color,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => item['page'] as Widget,
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}