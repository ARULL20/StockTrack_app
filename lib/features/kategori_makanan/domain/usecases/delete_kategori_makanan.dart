import '../repositories/kategori_makanan_repository.dart';

class DeleteKategoriMakanan {
  final KategoriMakananRepository repository;

  DeleteKategoriMakanan(this.repository);

  Future<void> call(int id) {
    return repository.delete(id);
  }
}
