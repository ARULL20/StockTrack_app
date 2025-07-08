import '../../domain/entities/gudang_entity.dart';
import '../../domain/repositories/gudang_repository.dart';
import '../datasources/gudang_remote_datasource.dart';
import '../models/gudang_model.dart';

class GudangRepositoryImpl implements GudangRepository {
  final GudangRemoteDatasource remoteDatasource;

  GudangRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<GudangEntity>> getAll() => remoteDatasource.getAll();

  @override
  Future<void> create(GudangEntity entity) async {
    final model = GudangModel(
      id: entity.id,
      nama: entity.nama,
      lokasi: entity.lokasi,
      deskripsi: entity.deskripsi,
    );
    await remoteDatasource.create(model);
  }

  @override
  Future<void> update(int id, GudangEntity entity) async {
    final model = GudangModel(
      id: id,
      nama: entity.nama,
      lokasi: entity.lokasi,
      deskripsi: entity.deskripsi,
    );
    await remoteDatasource.update(id, model);
  }

  @override
  Future<void> delete(int id) async {
    await remoteDatasource.delete(id);
  }
}
