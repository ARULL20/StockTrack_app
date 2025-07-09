import '../entities/makanan_entity.dart';
import '../repositories/makanan_repository.dart';

class UpdateMakanan {
  final MakananRepository repository;

  UpdateMakanan(this.repository);

  Future<void> call(MakananEntity makanan) {
    return repository.update(makanan);
  }
}
