import '../../domain/entities/gudang_entity.dart';
import '../../domain/repositories/gudang_repository.dart';
import '../datasources/gudang_remote_datasource.dart';
import '../models/gudang_model.dart';

class GudangRepositoryImpl implements GudangRepository {
  final GudangRemoteDatasource remoteDatasource;

  GudangRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<GudangEntity>> getAll() async {
  final models = await remoteDatasource.getAll();
  return models
      .map((model) => GudangEntity(
            id: model.id,
            nama: model.nama,
            lokasi: model.lokasi,
            deskripsi: model.deskripsi,
            latitude: model.latitude,
            longitude: model.longitude,
          ))
      .toList();
}


  @override
Future<void> create(GudangEntity entity) async {
  final model = GudangModel(
    id: entity.id,
    nama: entity.nama,
    lokasi: entity.lokasi,
    deskripsi: entity.deskripsi,
    latitude: entity.latitude,
    longitude: entity.longitude,
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
    latitude: entity.latitude,
    longitude: entity.longitude,
  );
  await remoteDatasource.update(id, model);
}


  @override
  Future<void> delete(int id) async {
    await remoteDatasource.delete(id);
  }
}
