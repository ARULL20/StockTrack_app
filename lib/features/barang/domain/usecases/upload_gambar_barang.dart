import 'dart:io';
import '../repositories/barang_repository.dart';

class UploadGambarBarang {
  final BarangRepository repository;

  UploadGambarBarang(this.repository);

  Future<void> call(int id, File gambar) async {
    await repository.uploadGambar(id, gambar);
  }
}