import '../entities/kategori_minuman.dart';
import '../repositories/kategori_minuman_repository.dart';

class GetAllKategoriMinuman {
  final KategoriMinumanRepository repository;

  GetAllKategoriMinuman(this.repository);

  Future<List<KategoriMinuman>> call() async {
    return await repository.getAll();
  }
}
