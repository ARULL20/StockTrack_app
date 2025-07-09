import '../../domain/entities/kategori_minuman.dart';

class KategoriMinumanModel extends KategoriMinuman {
  KategoriMinumanModel({
    required int id,
    required String nama,
    String? deskripsi,
  }) : super(
    id: id,
    nama: nama,
    deskripsi: deskripsi,
  );

  factory KategoriMinumanModel.fromJson(Map<String, dynamic> json) {
    return KategoriMinumanModel(
      id: json['id'] as int,
      nama: json['nama'] as String,
      deskripsi: json['deskripsi'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
    };
  }
}
