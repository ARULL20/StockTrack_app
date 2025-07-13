import '../repositories/makanan_repository.dart';

class UpdateMakanan {
  final MakananRepository repository;

  UpdateMakanan(this.repository);

  Future<void> call(int id, Map<String, dynamic> data) async {
    await repository.updateMakanan(id, data);
  }
}
