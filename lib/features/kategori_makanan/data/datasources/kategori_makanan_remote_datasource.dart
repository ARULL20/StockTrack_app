import 'package:stoktrack_app/core/api_client.dart';
import '../../domain/entities/kategori_makanan.dart';
import '../models/kategori_makanan_model.dart';

abstract class KategoriMakananRemoteDatasource {
  Future<List<KategoriMakanan>> getAll();
  Future<void> create(Map<String, dynamic> data);
  Future<void> update(int id, Map<String, dynamic> data);
  Future<void> delete(int id);
}

class KategoriMakananRemoteDatasourceImpl implements KategoriMakananRemoteDatasource {
  final ApiClient apiClient;

  KategoriMakananRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<List<KategoriMakanan>> getAll() async {
    final result = await apiClient.get('/kategori-makanan');
    final list = result['data'] as List;
    return list.map((json) => KategoriMakananModel.fromJson(json)).toList();
  }

  @override
  Future<void> create(Map<String, dynamic> data) async {
    await apiClient.post('/kategori-makanan', body: data);
  }

  @override
  Future<void> update(int id, Map<String, dynamic> data) async {
    await apiClient.put('/kategori-makanan/$id', body: data);
  }

  @override
  Future<void> delete(int id) async {
    await apiClient.delete('/kategori-makanan/$id');
  }
}

