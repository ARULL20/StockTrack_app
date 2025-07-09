// lib/features/barang_keluar/data/repositories/barang_keluar_repository_impl.dart
import 'package:stoktrack_app/features/barang_keluar/data/datasources/barang_keluar_remote_data_source.dart';

import '../../domain/entities/barang_keluar.dart';
import '../../domain/repositories/barang_keluar_repository.dart';

class BarangKeluarRepositoryImpl implements BarangKeluarRepository {
  final BarangKeluarRemoteDatasource remoteDatasource;

  BarangKeluarRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<BarangKeluar>> getAllBarangKeluar() {
    return remoteDatasource.getAllBarangKeluar();
  }

  @override
  Future<void> createBarangKeluar(Map<String, dynamic> data) {
    return remoteDatasource.createBarangKeluar(data);
  }

  @override
  Future<void> updateBarangKeluar(int id, Map<String, dynamic> data) {
    return remoteDatasource.updateBarangKeluar(id, data);
  }

  @override
  Future<void> deleteBarangKeluar(int id) {
    return remoteDatasource.deleteBarangKeluar(id);
  }
}
