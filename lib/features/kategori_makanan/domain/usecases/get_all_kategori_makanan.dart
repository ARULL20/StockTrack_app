import '../entities/kategori_makanan.dart';
import '../repositories/kategori_makanan_repository.dart';

class GetAllKategoriMakanan {
  final KategoriMakananRepository repository;

  GetAllKategoriMakanan(this.repository);

  Future<List<KategoriMakanan>> call() => repository.getAll();
}
