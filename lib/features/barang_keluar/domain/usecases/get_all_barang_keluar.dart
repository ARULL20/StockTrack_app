import '../entities/barang_keluar.dart';
import '../repositories/barang_keluar_repository.dart';

class GetAllBarangKeluar {
  final BarangKeluarRepository repository;

  GetAllBarangKeluar(this.repository);

  Future<List<BarangKeluar>> call() {
    return repository.getAllBarangKeluar();
  }
}
