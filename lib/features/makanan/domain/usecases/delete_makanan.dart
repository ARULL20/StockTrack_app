import '../repositories/makanan_repository.dart';

class DeleteMakanan {
  final MakananRepository repository;

  DeleteMakanan(this.repository);

  Future<void> call(int id) {
    return repository.delete(id); 
  }
}
