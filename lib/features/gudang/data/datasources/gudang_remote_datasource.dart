import 'package:stoktrack_app/core/api_client.dart';
import '../models/gudang_model.dart';

abstract class GudangRemoteDatasource {
  Future<List<GudangModel>> getAll();
  Future<GudangModel> create(GudangModel model);
  Future<GudangModel> update(int id, GudangModel model);
  Future<void> delete(int id);
}

class GudangRemoteDatasourceImpl implements GudangRemoteDatasource {
  final ApiClient client;

  GudangRemoteDatasourceImpl({required this.client});

  @override
  Future<List<GudangModel>> getAll() async {
    final response = await client.dio.get('/gudang');
    final data = response.data['data'] as List;
    return data.map((e) => GudangModel.fromJson(e)).toList();
  }

  @override
  Future<GudangModel> create(GudangModel model) async {
    final response = await client.dio.post('/gudang', data: model.toJson());
    return GudangModel.fromJson(response.data['data']);
  }

  @override
  Future<GudangModel> update(int id, GudangModel model) async {
    final response = await client.dio.put('/gudang/$id', data: model.toJson());
    return GudangModel.fromJson(response.data['data']);
  }

  @override
  Future<void> delete(int id) async {
    await client.dio.delete('/gudang/$id');
  }
}
