import '../repositories/barang_keluar_repository.dart';

class UpdateBarangKeluar {
  final BarangKeluarRepository repository;

  UpdateBarangKeluar(this.repository);

  Future<void> call(int id, Map<String, dynamic> data) async {
    await repository.updateBarangKeluar(id, data);
  }
}
