import 'dart:io';
import 'package:stoktrack_app/features/makanan/domain/entities/makanan_entity.dart';


abstract class MakananRepository {
  Future<List<Makanan>> getAllMakanan();
  Future<int> createMakanan(Map<String, dynamic> data);
  Future<void> updateMakanan(int id, Map<String, dynamic> data);
  Future<void> deleteMakanan(int id);
  Future<void> uploadGambar(int id, File gambar);
}
