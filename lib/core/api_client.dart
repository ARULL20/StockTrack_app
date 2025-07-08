import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final Dio dio;

  /// Base URL API
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  /// URL untuk akses file storage Laravel public (misal gambar)
  static const String storageUrl = 'http://10.0.2.2:8000/storage/';

  ApiClient()
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Accept': 'application/json',
          },
        )) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          print('➡️ REQUEST: ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ RESPONSE [${response.statusCode}]: ${response.data}');
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          print('❌ ERROR: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<dynamic> get(String path) async {
    final response = await dio.get(path);
    return response.data;
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? body}) async {
    final response = await dio.post(path, data: body);
    return response.data;
  }

  Future<dynamic> put(String path, {Map<String, dynamic>? body}) async {
    final response = await dio.put(path, data: body);
    return response.data;
  }

  Future<dynamic> delete(String path) async {
    final response = await dio.delete(path);
    return response.data;
  }

  /// Helper khusus untuk upload file dengan FormData (multipart)
  Future<dynamic> postMultipart(String path, FormData formData) async {
    final response = await dio.post(path, data: formData);
    return response.data;
  }
}
