import '../entities/makanan_entity.dart';
import '../repositories/makanan_repository.dart';

class GetAllMakanan {
  final MakananRepository repository;

  GetAllMakanan(this.repository);

  Future<List<MakananEntity>> call() {
    return repository.getAll();
  }
}
