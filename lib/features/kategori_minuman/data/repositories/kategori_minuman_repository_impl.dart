import '../../domain/entities/kategori_minuman.dart';
import '../../domain/repositories/kategori_minuman_repository.dart';
import '../datasources/kategori_minuman_remote_datasource.dart';

class KategoriMinumanRepositoryImpl implements KategoriMinumanRepository {
  final KategoriMinumanRemoteDatasource remoteDatasource;

  KategoriMinumanRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<KategoriMinuman>> getAll() => remoteDatasource.getAll();

  @override
  Future<void> create(Map<String, dynamic> data) => remoteDatasource.create(data);

  @override
  Future<void> update(int id, Map<String, dynamic> data) => remoteDatasource.update(id, data);

  @override
  Future<void> delete(int id) => remoteDatasource.delete(id);
}
