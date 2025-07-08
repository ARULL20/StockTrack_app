import '../../domain/entities/kategori_barang_entity.dart';
import '../../domain/repositories/kategori_barang_repository.dart';
import '../datasources/kategori_barang_remote_datasource.dart';
import '../models/kategori_barang_model.dart';

class KategoriBarangRepositoryImpl implements KategoriBarangRepository {
  final KategoriBarangRemoteDatasource remoteDatasource;

  KategoriBarangRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<KategoriBarangEntity>> getAll() async {
    final models = await remoteDatasource.getAll();
    return models.map((model) => KategoriBarangEntity(
      id: model.id,
      nama: model.nama,
      deskripsi: model.deskripsi,
    )).toList();
  }

  @override
  Future<KategoriBarangEntity> create(KategoriBarangEntity entity) async {
    final model = KategoriBarangModel(
      id: entity.id,
      nama: entity.nama,
      deskripsi: entity.deskripsi,
    );
    final result = await remoteDatasource.create(model);
    return KategoriBarangEntity(
      id: result.id,
      nama: result.nama,
      deskripsi: result.deskripsi,
    );
  }

  @override
  Future<KategoriBarangEntity> update(int id, KategoriBarangEntity entity) async {
    final model = KategoriBarangModel(
      id: entity.id,
      nama: entity.nama,
      deskripsi: entity.deskripsi,
    );
    final result = await remoteDatasource.update(id, model);
    return KategoriBarangEntity(
      id: result.id,
      nama: result.nama,
      deskripsi: result.deskripsi,
    );
  }

  @override
  Future<void> delete(int id) async {
    await remoteDatasource.delete(id);
  }
}
