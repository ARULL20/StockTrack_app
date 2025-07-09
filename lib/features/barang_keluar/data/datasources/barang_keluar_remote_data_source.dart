// lib/features/barang_keluar/data/datasources/barang_keluar_remote_datasource.dart
import 'package:stoktrack_app/core/api_client.dart';
import '../../domain/entities/barang_keluar.dart';
import '../models/barang_keluar_model.dart';

abstract class BarangKeluarRemoteDatasource {
  Future<List<BarangKeluar>> getAllBarangKeluar();
  Future<void> createBarangKeluar(Map<String, dynamic> data);
  Future<void> updateBarangKeluar(int id, Map<String, dynamic> data);
  Future<void> deleteBarangKeluar(int id);
}

class BarangKeluarRemoteDatasourceImpl implements BarangKeluarRemoteDatasource {
  final ApiClient apiClient;

  BarangKeluarRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<List<BarangKeluar>> getAllBarangKeluar() async {
    final result = await apiClient.get('/barang-keluar');
    return (result as List)
        .map((json) => BarangKeluarModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> createBarangKeluar(Map<String, dynamic> data) async {
    await apiClient.post('/barang-keluar', body: data);
  }

  @override
  Future<void> updateBarangKeluar(int id, Map<String, dynamic> data) async {
    await apiClient.put('/barang-keluar/$id', body: data);
  }

  @override
  Future<void> deleteBarangKeluar(int id) async {
    await apiClient.delete('/barang-keluar/$id');
  }
}
