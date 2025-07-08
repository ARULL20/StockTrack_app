import '../entities/gudang_entity.dart';

abstract class GudangRepository {
  Future<List<GudangEntity>> getAll();
  Future<void> create(GudangEntity entity);
  Future<void> update(int id, GudangEntity entity);
  Future<void> delete(int id);
}
