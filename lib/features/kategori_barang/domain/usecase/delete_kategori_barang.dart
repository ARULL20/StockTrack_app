import '../repositories/kategori_barang_repository.dart';

class DeleteKategoriBarang {
  final KategoriBarangRepository repository;

  DeleteKategoriBarang(this.repository);

  Future<void> call(int id) async {
    return await repository.delete(id);
  }
}
