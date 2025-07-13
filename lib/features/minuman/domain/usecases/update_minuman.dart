import '../repositories/minuman_repository.dart';

class UpdateMinuman {
  final MinumanRepository repository;

  UpdateMinuman(this.repository);

  Future<void> call(int id, Map<String, dynamic> data) async {
    await repository.update(id, data);
  }
}
