// lib/features/barang/data/repositories/barang_repository_impl.dart

import 'dart:io';
import '../../domain/entities/barang.dart';
import '../../domain/repositories/barang_repository.dart';
import '../datasources/barang_remote_datasource.dart';

class BarangRepositoryImpl implements BarangRepository {
  final BarangRemoteDatasource remoteDatasource;

  BarangRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Barang>> getAllBarang() => remoteDatasource.getAllBarang();

  @override
  Future<void> createBarang(Map<String, dynamic> data) => remoteDatasource.createBarang(data);

  @override
  Future<void> updateBarang(int id, Map<String, dynamic> data) => remoteDatasource.updateBarang(id, data);

  @override
  Future<void> deleteBarang(int id) => remoteDatasource.deleteBarang(id);

  @override
  Future<void> uploadGambar(int id, File gambar) => remoteDatasource.uploadGambar(id, gambar);
}
