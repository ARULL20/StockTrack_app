import '../../domain/repositories/laporan_repository.dart';
import '../datasources/laporan_remote_datasource.dart';

class LaporanRepositoryImpl implements LaporanRepository {
  final LaporanRemoteDatasource remoteDatasource;

  LaporanRepositoryImpl({required this.remoteDatasource});

  @override
  Future<double> getPemasukanTotal() {
    return remoteDatasource.getPemasukanTotal();
  }

  @override
  Future<double> getPengeluaranTotal() {
    return remoteDatasource.getPengeluaranTotal();
  }
}
