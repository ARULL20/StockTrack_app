import 'package:stoktrack_app/features/makanan/domain/entities/makanan_entity.dart';

class MakananModel extends Makanan {
  MakananModel({
    required int id,
    required String nama,
    String? deskripsi,
    required double harga,
    required int kategoriMakananId,
    String? gambar,
  }) : super(
          id: id,
          nama: nama,
          deskripsi: deskripsi,
          harga: harga,
          kategoriMakananId: kategoriMakananId,
          gambar: gambar,
        );

  factory MakananModel.fromJson(Map<String, dynamic> json) {
    return MakananModel(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      harga: double.tryParse(json['harga'].toString()) ?? 0,
      kategoriMakananId: json['kategori_makanan_id'],
      gambar: json['gambar'], // atau `gambar_url` kalau field-nya gambar_url
    );
  }
}
