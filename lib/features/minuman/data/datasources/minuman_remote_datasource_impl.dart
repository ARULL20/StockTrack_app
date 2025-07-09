import 'package:stoktrack_app/core/api_client.dart';
import '../models/minuman_model.dart';
import 'minuman_remote_datasource.dart';

class MinumanRemoteDatasourceImpl implements MinumanRemoteDatasource {
  final ApiClient apiClient;

  MinumanRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<List<MinumanModel>> getAll() async {
    final response = await apiClient.get('/minuman');
    return List<MinumanModel>.from(
      (response as List).map((item) => MinumanModel.fromJson(item)),
    );
  }

  @override
  Future<void> create(MinumanModel minuman) async {
    await apiClient.post('/minuman', body: minuman.toJson());
  }

  @override
  Future<void> update(MinumanModel minuman) async {
    await apiClient.put('/minuman/${minuman.id}', body: minuman.toJson());
  }

  @override
  Future<void> delete(int id) async {
    await apiClient.delete('/minuman/$id');
  }
}
