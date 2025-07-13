import 'dart:io';
import '../repositories/makanan_repository.dart';

class UploadGambarMakanan {
  final MakananRepository repository;

  UploadGambarMakanan(this.repository);

  Future<void> call(int id, File gambar) async {
    await repository.uploadGambar(id, gambar);
  }
}
