import '../entities/barang.dart';
import '../repositories/barang_repository.dart';

class GetAllBarang {
  final BarangRepository repository;

  GetAllBarang(this.repository);

  Future<List<Barang>> call() async {
    return await repository.getAllBarang();
  }
}