import '../entities/minuman_entity.dart';
import '../repositories/minuman_repository.dart';

class UpdateMinuman {
  final MinumanRepository repository;

  UpdateMinuman(this.repository);

  Future<void> call(MinumanEntity minuman) {
    return repository.update(minuman);
  }
}
