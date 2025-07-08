import '../entities/kategori_barang_entity.dart';
import '../repositories/kategori_barang_repository.dart';

class UpdateKategoriBarang {
  final KategoriBarangRepository repository;

  UpdateKategoriBarang(this.repository);

  Future<KategoriBarangEntity> call(int id, KategoriBarangEntity entity) async {
    return await repository.update(id, entity);
  }
}
