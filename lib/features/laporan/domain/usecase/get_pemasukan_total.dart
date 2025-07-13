import '../repositories/laporan_repository.dart';

class GetPemasukanTotal {
  final LaporanRepository repository;

  GetPemasukanTotal(this.repository);

  Future<double> call() async {
    return await repository.getPemasukanTotal();
  }
}