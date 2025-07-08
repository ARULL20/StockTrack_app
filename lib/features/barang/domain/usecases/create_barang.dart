// lib/features/barang/domain/usecases/create_barang.dart

import '../repositories/barang_repository.dart';

class CreateBarang {
  final BarangRepository repository;

  CreateBarang(this.repository);

  Future<void> call(Map<String, dynamic> data) async {
    await repository.createBarang(data);
  }
}
