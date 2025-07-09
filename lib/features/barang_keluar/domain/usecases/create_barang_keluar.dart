// lib/features/barang_keluar/domain/usecases/create_barang_keluar.dart

import '../repositories/barang_keluar_repository.dart';

class CreateBarangKeluar {
  final BarangKeluarRepository repository;

  CreateBarangKeluar(this.repository);

  Future<void> call(Map<String, dynamic> data) async {
    await repository.createBarangKeluar(data);
  }
}
