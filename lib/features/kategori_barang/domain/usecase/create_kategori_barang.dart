import '../entities/kategori_barang_entity.dart';
import '../repositories/kategori_barang_repository.dart';

class CreateKategoriBarang {
  final KategoriBarangRepository repository;

  CreateKategoriBarang(this.repository);

  Future<KategoriBarangEntity> call(KategoriBarangEntity entity) async {
    return await repository.create(entity);
  }
}
