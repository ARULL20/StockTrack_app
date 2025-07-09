import '../repositories/kategori_makanan_repository.dart';

class UpdateKategoriMakanan {
  final KategoriMakananRepository repository;

  UpdateKategoriMakanan(this.repository);

  Future<void> call(int id, Map<String, dynamic> data) {
    return repository.update(id, data);
  }
}
