// lib/features/barang/domain/usecases/create_barang.dart

import '../repositories/barang_repository.dart';

class CreateBarang {
  final BarangRepository repository;

  CreateBarang(this.repository);

  Future<int> call(Map<String, dynamic> data) async {
  return await repository.createBarang(data);
}

}