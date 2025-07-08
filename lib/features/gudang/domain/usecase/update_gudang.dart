import '../entities/gudang_entity.dart';
import '../repositories/gudang_repository.dart';

class UpdateGudang {
  final GudangRepository repository;

  UpdateGudang(this.repository);

  Future<void> call(int id, GudangEntity entity) => repository.update(id, entity);
}
