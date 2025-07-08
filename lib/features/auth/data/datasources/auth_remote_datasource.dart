import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> getProfile(String token);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDatasourceImpl({required this.client});

  final String baseUrl = 'http://10.0.2.2:8000/api';

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final token = body['access_token'];

      // 🔑 Setelah dapat token, ambil profil user
      return getProfile(token);
    } else {
      throw Exception('Login gagal: ${response.body}');
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'role': 'pegawai', // Kalau mau default
      }),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final token = body['access_token'];

      // 🔑 Setelah register, ambil profil user
      return getProfile(token);
    } else {
      throw Exception('Register gagal: ${response.body}');
    }
  }

  @override
Future<UserModel> getProfile(String token) async {
  final response = await client.get(
    Uri.parse('$baseUrl/user'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  print('📥 RESPONSE BODY getProfile: ${response.body}');

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    print('📤 PARSED BODY: $body');

    return UserModel.fromJson(body, token);
  } else {
    throw Exception('Gagal ambil profil: ${response.body}');
  }
}

}
