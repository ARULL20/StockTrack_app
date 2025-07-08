class UserEntity {
  final int id;
  final String name;
  final String email;
  final String token; // JWT
  final String role;  // 'admin' atau 'pegawai'

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.role,
  });
}
