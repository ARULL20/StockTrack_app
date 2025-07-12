// lib/features/barang/domain/repositories/barang_repository.dart

import 'dart:io';
import '../entities/barang.dart';

abstract class BarangRepository {
  Future<List<Barang>> getAllBarang();
  Future<int> createBarang(Map<String, dynamic> data);
  Future<void> updateBarang(int id, Map<String, dynamic> data);
  Future<void> deleteBarang(int id);
  Future<void> uploadGambar(int id, File gambar);
}