import '../repositories/barang_repository.dart';

class DeleteBarang {
  final BarangRepository repository;

  DeleteBarang(this.repository);

  Future<void> call(int id) async {
    await repository.deleteBarang(id);
  }
}