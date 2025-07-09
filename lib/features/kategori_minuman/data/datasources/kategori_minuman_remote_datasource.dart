import 'package:stoktrack_app/core/api_client.dart';
import '../../domain/entities/kategori_minuman.dart';
import '../models/kategori_minuman_model.dart';

abstract class KategoriMinumanRemoteDatasource {
  Future<List<KategoriMinuman>> getAll();
  Future<void> create(Map<String, dynamic> data);
  Future<void> update(int id, Map<String, dynamic> data);
  Future<void> delete(int id);
}

class KategoriMinumanRemoteDatasourceImpl implements KategoriMinumanRemoteDatasource {
  final ApiClient apiClient;

  KategoriMinumanRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<List<KategoriMinuman>> getAll() async {
    final response = await apiClient.get('/kategori-minuman');
    print('✅ RAW GET: $response');
    final list = response as List;
    final mapped = list.map((json) => KategoriMinumanModel.fromJson(json)).toList();
    print('✅ MAPPED: $mapped');
    return mapped;
  }

  @override
  Future<void> create(Map<String, dynamic> data) async {
    final res = await apiClient.post('/kategori-minuman', body: data);
    print('✅ CREATED: $res');
  }

  @override
  Future<void> update(int id, Map<String, dynamic> data) async {
    final res = await apiClient.put('/kategori-minuman/$id', body: data);
    print('✅ UPDATED: $res');
  }

  @override
  Future<void> delete(int id) async {
    final res = await apiClient.delete('/kategori-minuman/$id');
    print('✅ DELETED: $res');
  }
}
