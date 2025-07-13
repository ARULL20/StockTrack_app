import 'dart:io';
import '../repositories/minuman_repository.dart';

class UploadGambarMinuman {
  final MinumanRepository repository;

  UploadGambarMinuman(this.repository);

  Future<void> call(int id, File gambar) async {
    await repository.uploadGambar(id, gambar);
  }
}
