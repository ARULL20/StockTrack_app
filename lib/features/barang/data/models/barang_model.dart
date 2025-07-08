// lib/features/barang/data/models/barang_model.dart

import '../../domain/entities/barang.dart';

class BarangModel extends Barang {
  BarangModel({
    required int id,
    required String nama,
    String? deskripsi,
    String? gambar,
    required int stok,
    required double harga,
    required int kategoriBarangId,
    required int gudangId,
  }) : super(
          id: id,
          nama: nama,
          deskripsi: deskripsi,
          gambar: gambar,
          stok: stok,
          harga: harga,
          kategoriBarangId: kategoriBarangId,
          gudangId: gudangId,
        );

  factory BarangModel.fromJson(Map<String, dynamic> json) {
    return BarangModel(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar'],
      stok: json['stok'],
      harga: double.tryParse(json['harga'].toString()) ?? 0,
      kategoriBarangId: json['kategori_barang_id'],
      gudangId: json['gudang_id'],
    );
  }
}
