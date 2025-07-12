import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaporanRemoteDatasource {
  final Dio dio;

  LaporanRemoteDatasource({required this.dio});

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
}
