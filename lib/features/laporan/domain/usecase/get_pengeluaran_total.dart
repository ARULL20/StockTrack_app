import '../repositories/laporan_repository.dart';

class GetPengeluaranTotal {
  final LaporanRepository repository;

  GetPengeluaranTotal(this.repository);

  Future<double> call() async {
    return await repository.getPengeluaranTotal();
  }
}
