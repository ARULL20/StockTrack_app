import '../../domain/entities/makanan_entity.dart';
import '../../domain/repositories/makanan_repository.dart';
import '../datasources/makanan_remote_datasource.dart';
import '../models/makanan_model.dart';

class MakananRepositoryImpl implements MakananRepository {
  final MakananRemoteDatasource remoteDatasource;

  MakananRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<MakananEntity>> getAll() async {
    final list = await remoteDatasource.getAll();
    return list;
  }

  @override
  Future<void> create(MakananEntity makanan) async {
    final model = MakananModel(
      id: makanan.id,
      nama: makanan.nama,
      deskripsi: makanan.deskripsi,
      harga: makanan.harga,
      kategoriMakananId: makanan.kategoriMakananId,
    );
    await remoteDatasource.create(model);
  }

  @override
  Future<void> update(MakananEntity makanan) async {
    final model = MakananModel(
      id: makanan.id,
      nama: makanan.nama,
      deskripsi: makanan.deskripsi,
      harga: makanan.harga,
      kategoriMakananId: makanan.kategoriMakananId,
    );
    await remoteDatasource.update(model);
  }

  @override
  Future<void> delete(int id) async {
    await remoteDatasource.delete(id);
  }
}
