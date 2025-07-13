import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaporanRemoteDatasource {
  final Dio dio;

  LaporanRemoteDatasource({required this.dio});

  // ✅ Implementasi aslinya, BUKAN komentar
  Future<double> getPemasukanTotal() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await dio.get(
      '/laporan/pemasukan',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    return double.parse(response.data['total_pemasukan'].toString());
  }

  Future<double> getPengeluaranTotal() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await dio.get(
      '/laporan/pengeluaran',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    return double.parse(response.data['total_pengeluaran'].toString());
  }

  // 🔽 Tambah ini untuk export PDF pemasukan
  Future<File> downloadPemasukanPDF() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await dio.get(
      '/laporan/pemasukan/export',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        responseType: ResponseType.bytes, // wajib!
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/laporan_pemasukan.pdf');

    await file.writeAsBytes(response.data);

    return file;
  }

  // 🔽 Tambah ini untuk export PDF pengeluaran
  Future<File> downloadPengeluaranPDF() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await dio.get(
      '/laporan/pengeluaran/export',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        responseType: ResponseType.bytes,
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/laporan_pengeluaran.pdf');

    await file.writeAsBytes(response.data);

    return file;
  }
}
