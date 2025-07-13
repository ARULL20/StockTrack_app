import 'dart:io';

abstract class LaporanRepository {
  Future<double> getPemasukanTotal();
  Future<double> getPengeluaranTotal();

  // Tambah:
  Future<File> downloadPemasukanPDF();
  Future<File> downloadPengeluaranPDF();
}
