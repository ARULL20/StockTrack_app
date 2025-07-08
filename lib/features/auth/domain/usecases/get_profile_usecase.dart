import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetProfileUsecase {
  final AuthRepository repository;

  GetProfileUsecase(this.repository);

  Future<UserEntity> call(String token) {
    return repository.getProfile(token);
  }
}
