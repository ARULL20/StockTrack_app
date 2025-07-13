import 'dart:io';
import 'package:dio/dio.dart';

import 'package:stoktrack_app/core/api_client.dart';
import '../models/minuman_model.dart';

abstract class MinumanRemoteDatasource {
  Future<List<MinumanModel>> getAll();
  Future<int> create(Map<String, dynamic> data);
  Future<void> update(int id, Map<String, dynamic> data);
  Future<void> delete(int id);
  Future<void> uploadGambar(int id, File gambar);
}

class MinumanRemoteDatasourceImpl implements MinumanRemoteDatasource {
  final ApiClient apiClient;

  MinumanRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<List<MinumanModel>> getAll() async {
    final result = await apiClient.get('/minuman');
    return (result as List)
        .map((json) => MinumanModel.fromJson(json))
        .toList();
  }

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final response = await apiClient.post('/minuman', body: data);
    return response['id'] ?? response['data']['id'];
  }

  @override
  Future<void> update(int id, Map<String, dynamic> data) async {
    await apiClient.put('/minuman/$id', body: data);
  }

  @override
  Future<void> delete(int id) async {
    await apiClient.delete('/minuman/$id');
  }

  @override
  Future<void> uploadGambar(int id, File gambar) async {
    final fileName = gambar.path.split('/').last;

    final formData = FormData.fromMap({
      'gambar': await MultipartFile.fromFile(
        gambar.path,
        filename: fileName,
      ),
    });

    await apiClient.postMultipart('/minuman/$id/upload-gambar', formData);
  }
}
