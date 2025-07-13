import 'dart:io';

import '../entities/minuman_entity.dart';

abstract class MinumanRepository {
  Future<List<MinumanEntity>> getAll();
  Future<int> create(Map<String, dynamic> data);
  Future<void> update(int id, Map<String, dynamic> data);
  Future<void> delete(int id);
  Future<void> uploadGambar(int id, File gambar);
}
