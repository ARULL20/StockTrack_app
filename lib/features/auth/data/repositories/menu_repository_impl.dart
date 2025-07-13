import 'package:flutter/material.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  @override
  List<MenuItem> getMenuItems() {
    return [
      MenuItem(
        title: 'Kelola Kategori Barang',
        icon: Icons.category,
        route: '/kategori-barang',
        color: Colors.green.shade600,
      ),
      MenuItem(
        title: 'Kelola Gudang',
        icon: Icons.warehouse,
        route: '/gudang',
        color: Colors.green.shade700,
      ),
      MenuItem(
        title: 'Kelola Barang',
        icon: Icons.inventory,
        route: '/barang',
        color: Colors.green.shade500,
      ),
      MenuItem(
        title: 'Kelola Kategori Makanan',
        icon: Icons.restaurant_menu,
        route: '/kategori-makanan',
        color: Colors.green.shade800,
      ),
      MenuItem(
        title: 'Kelola Kategori Minuman',
        icon: Icons.local_drink,
        route: '/kategori-minuman',
        color: Colors.green.shade600,
      ),
      MenuItem(
        title: 'Kelola Makanan',
        icon: Icons.fastfood,
        route: '/makanan',
        color: Colors.green.shade700,
      ),
      MenuItem(
        title: 'Kelola Minuman',
        icon: Icons.local_cafe,
        route: '/minuman',
        color: Colors.green.shade500,
      ),
      MenuItem(
        title: 'Barang Keluar',
        icon: Icons.exit_to_app,
        route: '/barang-keluar',
        color: Colors.green.shade800,
      ),
    ];
  }
}