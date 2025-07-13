import 'package:flutter/material.dart';
import '../../domain/entities/menu_item.dart';
import 'menu_card.dart';

class MenuGrid extends StatelessWidget {
  final List<MenuItem> menuItems;
  final Function(String) onMenuTap;

  const MenuGrid({
    super.key,
    required this.menuItems,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: menuItems.map((item) {
          return MenuCard(
            menuItem: item,
            onTap: () => onMenuTap(item.route),
          );
        }).toList(),
      ),
    );
  }
}
