import 'package:stoktrack_app/features/auth/domain/entities/menu_item.dart';

abstract class MenuRepository {
  List<MenuItem> getMenuItems();
}