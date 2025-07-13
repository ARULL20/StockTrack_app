import 'dart:io';
import 'package:stoktrack_app/features/makanan/domain/entities/makanan_entity.dart';

import '../../domain/repositories/makanan_repository.dart';
import '../datasources/makanan_remote_datasource.dart';

class MakananRepositoryImpl implements MakananRepository {
  final MakananRemoteDatasource remoteDatasource;

  MakananRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Makanan>> getAllMakanan() =>
      remoteDatasource.getAllMakanan();

  @override
  Future<int> createMakanan(Map<String, dynamic> data) =>
      remoteDatasource.createMakanan(data);

  @override
  Future<void> updateMakanan(int id, Map<String, dynamic> data) =>
      remoteDatasource.updateMakanan(id, data);

  @override
  Future<void> deleteMakanan(int id) =>
      remoteDatasource.deleteMakanan(id);

  @override
  Future<void> uploadGambar(int id, File gambar) =>
      remoteDatasource.uploadGambar(id, gambar);
}
