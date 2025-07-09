import '../entities/makanan_entity.dart';

abstract class MakananRepository {
  Future<List<MakananEntity>> getAll();
  Future<void> create(MakananEntity makanan);
  Future<void> update(MakananEntity makanan);
  Future<void> delete(int id);

}
