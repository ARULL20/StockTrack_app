import 'dart:io';
import '../datasources/laporan_remote_datasource.dart';
import '../../domain/repositories/laporan_repository.dart';

class LaporanRepositoryImpl implements LaporanRepository {
  final LaporanRemoteDatasource remoteDatasource;

  LaporanRepositoryImpl({required this.remoteDatasource});

  @override
  Future<double> getPemasukanTotal() => remoteDatasource.getPemasukanTotal();

  @override
  Future<double> getPengeluaranTotal() => remoteDatasource.getPengeluaranTotal();

  @override
  Future<File> downloadPemasukanPDF() => remoteDatasource.downloadPemasukanPDF();

  @override
  Future<File> downloadPengeluaranPDF() => remoteDatasource.downloadPengeluaranPDF();
}
