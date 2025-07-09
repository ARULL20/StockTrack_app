import '../models/minuman_model.dart';

abstract class MinumanRemoteDatasource {
  Future<List<MinumanModel>> getAll();
  Future<void> create(MinumanModel minuman);
  Future<void> update(MinumanModel minuman);
  Future<void> delete(int id);
}
