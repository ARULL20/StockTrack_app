// lib/features/barang/domain/usecases/update_barang.dart

import '../repositories/barang_repository.dart';

class UpdateBarang {
  final BarangRepository repository;

  UpdateBarang(this.repository);

  Future<void> call(int id, Map<String, dynamic> data) async {
    await repository.updateBarang(id, data);
  }
}