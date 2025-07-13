import 'dart:io';

import '../../domain/repositories/minuman_repository.dart';
import '../../domain/entities/minuman_entity.dart';
import '../datasources/minuman_remote_datasource.dart';

class MinumanRepositoryImpl implements MinumanRepository {
  final MinumanRemoteDatasource remoteDatasource;

  MinumanRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<MinumanEntity>> getAll() =>
      remoteDatasource.getAll();

  @override
  Future<int> create(Map<String, dynamic> data) =>
      remoteDatasource.create(data);

  @override
  Future<void> update(int id, Map<String, dynamic> data) =>
      remoteDatasource.update(id, data);

  @override
  Future<void> delete(int id) =>
      remoteDatasource.delete(id);

  @override
  Future<void> uploadGambar(int id, File gambar) =>
      remoteDatasource.uploadGambar(id, gambar);
}
