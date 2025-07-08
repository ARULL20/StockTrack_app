import '../entities/kategori_barang_entity.dart';

abstract class KategoriBarangRepository {
  Future<List<KategoriBarangEntity>> getAll();
  Future<KategoriBarangEntity> create(KategoriBarangEntity entity);
  Future<KategoriBarangEntity> update(int id, KategoriBarangEntity entity);
  Future<void> delete(int id);
}
