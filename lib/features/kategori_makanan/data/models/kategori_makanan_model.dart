import '../../domain/entities/kategori_makanan.dart';

class KategoriMakananModel extends KategoriMakanan {
  KategoriMakananModel({
    required int id,
    required String nama,
    String? deskripsi,
  }) : super(id: id, nama: nama, deskripsi: deskripsi);

  factory KategoriMakananModel.fromJson(Map<String, dynamic> json) {
    return KategoriMakananModel(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'deskripsi': deskripsi,
    };
  }
}
