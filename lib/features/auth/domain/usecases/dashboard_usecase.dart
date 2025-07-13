import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../entities/menu_item.dart';
import '../repositories/menu_repository.dart';

class DashboardUseCase {
  final MenuRepository menuRepository;

  DashboardUseCase({required this.menuRepository});

  List<MenuItem> getMenuItems() {
    return menuRepository.getMenuItems();
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    // Navigation will be handled in presentation layer
  }
}