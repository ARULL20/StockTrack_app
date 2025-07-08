import 'package:stoktrack_app/features/auth/domain/entities/user_entity.dart';
import 'package:stoktrack_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:stoktrack_app/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<UserEntity> login(String email, String password) {
    return remoteDatasource.login(email, password);
  }

  @override
  Future<UserEntity> register(String name, String email, String password) {
    return remoteDatasource.register(name, email, password);
  }

  @override
  Future<UserEntity> getProfile(String token) {
    return remoteDatasource.getProfile(token);
  }
}
