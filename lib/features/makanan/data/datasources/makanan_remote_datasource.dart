import '../models/makanan_model.dart';

abstract class MakananRemoteDatasource {
  Future<List<MakananModel>> getAll();
  Future<void> create(MakananModel makanan);
  Future<void> update(MakananModel makanan);
  Future<void> delete(int id);
}
