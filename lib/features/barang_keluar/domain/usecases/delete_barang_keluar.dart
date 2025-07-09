import '../repositories/barang_keluar_repository.dart';

class DeleteBarangKeluar {
  final BarangKeluarRepository repository;

  DeleteBarangKeluar(this.repository);

  Future<void> call(int id) {
    return repository.deleteBarangKeluar(id);
  }
}
