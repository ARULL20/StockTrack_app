import 'dart:io';
import 'package:dio/dio.dart';
import 'package:stoktrack_app/core/api_client.dart';
import 'package:stoktrack_app/features/makanan/domain/entities/makanan_entity.dart';

import '../models/makanan_model.dart';

abstract class MakananRemoteDatasource {
  Future<List<Makanan>> getAllMakanan();
  Future<int> createMakanan(Map<String, dynamic> data);
  Future<void> updateMakanan(int id, Map<String, dynamic> data);
  Future<void> deleteMakanan(int id);
  Future<void> uploadGambar(int id, File gambar);
}

class MakananRemoteDatasourceImpl implements MakananRemoteDatasource {
  final ApiClient apiClient;

  MakananRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<List<Makanan>> getAllMakanan() async {
    final result = await apiClient.get('/makanan');
    return (result as List)
        .map((json) => MakananModel.fromJson(json))
        .toList();
  }

  @override
  Future<int> createMakanan(Map<String, dynamic> data) async {
    final response = await apiClient.post('/makanan', body: data);
    return response['id'] ?? response['data']['id'];
  }

  @override
  Future<void> updateMakanan(int id, Map<String, dynamic> data) async {
    await apiClient.put('/makanan/$id', body: data);
  }

  @override
  Future<void> deleteMakanan(int id) async {
    await apiClient.delete('/makanan/$id');
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

    await apiClient.postMultipart('/makanan/$id/upload-gambar', formData);
  }
}
