import '../entities/kategori_makanan.dart';

abstract class KategoriMakananRepository {
  Future<List<KategoriMakanan>> getAll();
  Future<void> create(Map<String, dynamic> data);
  Future<void> update(int id, Map<String, dynamic> data);
  Future<void> delete(int id);
}
