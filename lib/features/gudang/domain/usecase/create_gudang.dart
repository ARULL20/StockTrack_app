import '../entities/gudang_entity.dart';
import '../repositories/gudang_repository.dart';

class CreateGudang {
  final GudangRepository repository;

  CreateGudang(this.repository);

  Future<void> call(GudangEntity entity) => repository.create(entity);
}
