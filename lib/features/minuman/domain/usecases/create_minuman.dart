import '../repositories/minuman_repository.dart';

class CreateMinuman {
  final MinumanRepository repository;

  CreateMinuman(this.repository);

  Future<int> call(Map<String, dynamic> data) async {
    return await repository.create(data);
  }
}
