import 'dart:io';
import 'package:dio/dio.dart';
import 'package:stoktrack_app/core/api_client.dart';

import '../../domain/entities/barang.dart';
import '../models/barang_model.dart';

abstract class BarangRemoteDatasource {
  Future<List<Barang>> getAllBarang();
  Future<int> createBarang(Map<String, dynamic> data);
  Future<void> updateBarang(int id, Map<String, dynamic> data);
  Future<void> deleteBarang(int id);
  Future<void> uploadGambar(int id, File gambar);
}

class BarangRemoteDatasourceImpl implements BarangRemoteDatasource {
  final ApiClient apiClient;

  BarangRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<List<Barang>> getAllBarang() async {
    final result = await apiClient.get('/barang');
    return (result as List)
        .map((json) => BarangModel.fromJson(json))
        .toList();
  }

  @override
Future<int> createBarang(Map<String, dynamic> data) async {
  final response = await apiClient.post('/barang', body: data);
  return response['data']['id']; // ambil ID dari response
}


  @override
  Future<void> updateBarang(int id, Map<String, dynamic> data) async {
    await apiClient.put('/barang/$id', body: data);
  }

  @override
  Future<void> deleteBarang(int id) async {
    await apiClient.delete('/barang/$id');
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

    await apiClient.postMultipart('/barang/$id/upload-gambar', formData);
  }
}