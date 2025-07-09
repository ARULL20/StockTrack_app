import '../../domain/entities/minuman_entity.dart';
import '../../domain/repositories/minuman_repository.dart';
import '../datasources/minuman_remote_datasource.dart';
import '../models/minuman_model.dart';

class MinumanRepositoryImpl implements MinumanRepository {
  final MinumanRemoteDatasource remoteDatasource;

  MinumanRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<MinumanEntity>> getAll() async {
    return await remoteDatasource.getAll();
  }

  @override
  Future<void> create(MinumanEntity minuman) async {
    final model = MinumanModel(
      id: minuman.id,
      nama: minuman.nama,
      deskripsi: minuman.deskripsi,
      harga: minuman.harga,
      kategoriMinumanId: minuman.kategoriMinumanId,
    );
    await remoteDatasource.create(model);
  }

  @override
  Future<void> update(MinumanEntity minuman) async {
    final model = MinumanModel(
      id: minuman.id,
      nama: minuman.nama,
      deskripsi: minuman.deskripsi,
      harga: minuman.harga,
      kategoriMinumanId: minuman.kategoriMinumanId,
    );
    await remoteDatasource.update(model);
  }

  @override
  Future<void> delete(int id) async {
    await remoteDatasource.delete(id);
  }
}
