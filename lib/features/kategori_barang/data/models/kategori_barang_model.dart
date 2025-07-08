import '../../domain/entities/kategori_barang_entity.dart';

class KategoriBarangModel extends KategoriBarangEntity {
  KategoriBarangModel({
    required int id,
    required String nama,
    String? deskripsi,
  }) : super(id: id, nama: nama, deskripsi: deskripsi);

  factory KategoriBarangModel.fromJson(Map<String, dynamic> json) {
    return KategoriBarangModel(
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
