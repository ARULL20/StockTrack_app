import '../repositories/kategori_makanan_repository.dart';

class CreateKategoriMakanan {
  final KategoriMakananRepository repository;

  CreateKategoriMakanan(this.repository);

  Future<void> call(Map<String, dynamic> data) {
    return repository.create(data);
  }
}
