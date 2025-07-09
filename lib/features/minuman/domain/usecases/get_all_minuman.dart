import '../entities/minuman_entity.dart';
import '../repositories/minuman_repository.dart';

class GetAllMinuman {
  final MinumanRepository repository;

  GetAllMinuman(this.repository);

  Future<List<MinumanEntity>> call() {
    return repository.getAll();
  }
}
