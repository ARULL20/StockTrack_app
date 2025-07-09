import '../entities/minuman_entity.dart';

abstract class MinumanRepository {
  Future<List<MinumanEntity>> getAll();
  Future<void> create(MinumanEntity minuman);
  Future<void> update(MinumanEntity minuman);
  Future<void> delete(int id);
}
