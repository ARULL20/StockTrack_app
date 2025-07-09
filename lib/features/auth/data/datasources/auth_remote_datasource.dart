import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> getProfile(String token);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl({required this.dio});

  final String baseUrl = 'http://10.0.2.2:8000/api';

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await dio.post(
      '$baseUrl/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final body = response.data;
      final token = body['access_token'];
      return getProfile(token);
    } else {
      throw Exception('Login gagal: ${response.data}');
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final response = await dio.post(
      '$baseUrl/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'role': 'pegawai',
      },
    );

    if (response.statusCode == 200) {
      final body = response.data;
      final token = body['access_token'];
      return getProfile(token);
    } else {
      throw Exception('Register gagal: ${response.data}');
    }
  }

  @override
  Future<UserModel> getProfile(String token) async {
    final response = await dio.get(
      '$baseUrl/user',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    print('📥 RESPONSE BODY getProfile: ${response.data}');

    if (response.statusCode == 200) {
      final body = response.data;
      print('📤 PARSED BODY: $body');

      return UserModel.fromJson(body, token);
    } else {
      throw Exception('Gagal ambil profil: ${response.data}');
    }
  }
}
