import '../entities/minuman_entity.dart';
import '../repositories/minuman_repository.dart';

class CreateMinuman {
  final MinumanRepository repository;

  CreateMinuman(this.repository);

  Future<void> call(MinumanEntity minuman) {
    return repository.create(minuman);
  }
}
