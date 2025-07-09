// lib/features/barang_keluar/domain/repositories/barang_keluar_repository.dart
import '../entities/barang_keluar.dart';

abstract class BarangKeluarRepository {
  Future<List<BarangKeluar>> getAllBarangKeluar();
  Future<void> createBarangKeluar(Map<String, dynamic> data);
  Future<void> updateBarangKeluar(int id, Map<String, dynamic> data);
  Future<void> deleteBarangKeluar(int id);
}
