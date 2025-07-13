import '../repositories/makanan_repository.dart';

class CreateMakanan {
  final MakananRepository repository;

  CreateMakanan(this.repository);

  Future<int> call(Map<String, dynamic> data) async {
    return await repository.createMakanan(data);
  }
}
