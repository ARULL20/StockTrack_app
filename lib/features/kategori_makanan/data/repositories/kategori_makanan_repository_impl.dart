import '../../domain/entities/kategori_makanan.dart';
import '../../domain/repositories/kategori_makanan_repository.dart';
import '../datasources/kategori_makanan_remote_datasource.dart';

class KategoriMakananRepositoryImpl implements KategoriMakananRepository {
  final KategoriMakananRemoteDatasource remoteDatasource;

  KategoriMakananRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<KategoriMakanan>> getAll() => remoteDatasource.getAll();

  @override
  Future<void> create(Map<String, dynamic> data) => remoteDatasource.create(data);

  @override
  Future<void> update(int id, Map<String, dynamic> data) => remoteDatasource.update(id, data);

  @override
  Future<void> delete(int id) => remoteDatasource.delete(id);
}
