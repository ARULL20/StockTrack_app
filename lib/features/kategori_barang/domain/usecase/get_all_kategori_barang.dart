import '../entities/kategori_barang_entity.dart';
import '../repositories/kategori_barang_repository.dart';

class GetAllKategoriBarang {
  final KategoriBarangRepository repository;

  GetAllKategoriBarang(this.repository);

  Future<List<KategoriBarangEntity>> call() async {
    return await repository.getAll();
  }
}
