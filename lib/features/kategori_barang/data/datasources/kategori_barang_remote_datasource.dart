import '../../../../core/api_client.dart';
import '../models/kategori_barang_model.dart';

abstract class KategoriBarangRemoteDatasource {
  Future<List<KategoriBarangModel>> getAll();
  Future<KategoriBarangModel> create(KategoriBarangModel model);
  Future<KategoriBarangModel> update(int id, KategoriBarangModel model);
  Future<void> delete(int id);
}

class KategoriBarangRemoteDatasourceImpl implements KategoriBarangRemoteDatasource {
  final ApiClient client;

  KategoriBarangRemoteDatasourceImpl({required this.client});

  @override
  Future<List<KategoriBarangModel>> getAll() async {
    final response = await client.dio.get('/kategori-barang');
    final data = response.data['data'] as List;
    return data.map((json) => KategoriBarangModel.fromJson(json)).toList();
  }

  @override
  Future<KategoriBarangModel> create(KategoriBarangModel model) async {
    final response = await client.dio.post('/kategori-barang', data: model.toJson());
    return KategoriBarangModel.fromJson(response.data['data']);
  }

  @override
  Future<KategoriBarangModel> update(int id, KategoriBarangModel model) async {
    final response = await client.dio.put('/kategori-barang/$id', data: model.toJson());
    return KategoriBarangModel.fromJson(response.data['data']);
  }

  @override
  Future<void> delete(int id) async {
    await client.dio.delete('/kategori-barang/$id');
  }
}
