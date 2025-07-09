import '../entities/makanan_entity.dart';
import '../repositories/makanan_repository.dart';

class CreateMakanan {
  final MakananRepository repository;

  CreateMakanan(this.repository);

  Future<void> call(MakananEntity makanan) {
    return repository.create(makanan);
  }
}
