import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required int id,
    required String name,
    required String email,
    required String token,
    required String role,
  }) : super(
          id: id,
          name: name,
          email: email,
          token: token,
          role: role,
        );

  factory UserModel.fromJson(Map<String, dynamic> json, String token) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: token,
      role: json['role'],
    );
  }
}
