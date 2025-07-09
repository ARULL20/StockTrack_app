import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<UserModel> login(String email, String password) {
    return remoteDatasource.login(email, password);
  }

  @override
  Future<UserModel> register(String name, String email, String password) {
    return remoteDatasource.register(name, email, password);
  }

  @override
  Future<UserModel> getProfile(String token) {
    return remoteDatasource.getProfile(token);
  }
}
