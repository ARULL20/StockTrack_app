import '../repositories/minuman_repository.dart';

class DeleteMinuman {
  final MinumanRepository repository;

  DeleteMinuman(this.repository);

  Future<void> call(int id) {
    return repository.delete(id);
  }
}
