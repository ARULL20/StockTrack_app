import 'package:stoktrack_app/core/api_client.dart';
import '../models/makanan_model.dart';
import 'makanan_remote_datasource.dart';

class MakananRemoteDatasourceImpl implements MakananRemoteDatasource {
  final ApiClient apiClient;

  MakananRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<List<MakananModel>> getAll() async {
    final response = await apiClient.get('/makanan');
    final List<dynamic> data = response;
    return data.map((e) => MakananModel.fromJson(e)).toList();
  }

  @override
  Future<void> create(MakananModel makanan) async {
    await apiClient.post('/makanan', body: makanan.toJson());
  }

  @override
  Future<void> update(MakananModel makanan) async {
    await apiClient.put('/makanan/${makanan.id}', body: makanan.toJson());
  }

  @override
  Future<void> delete(int id) async {
    await apiClient.delete('/makanan/$id');
  }
}
