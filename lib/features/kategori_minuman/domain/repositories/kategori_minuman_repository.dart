import '../entities/kategori_minuman.dart';

abstract class KategoriMinumanRepository {
  Future<List<KategoriMinuman>> getAll();
  Future<void> create(Map<String, dynamic> data);
  Future<void> update(int id, Map<String, dynamic> data);
  Future<void> delete(int id);
}
