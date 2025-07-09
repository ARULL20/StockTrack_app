import '../../domain/entities/makanan_entity.dart';

class MakananModel extends MakananEntity {
  const MakananModel({
    required int id,
    required String nama,
    required String deskripsi,
    required double harga,
    required int kategoriMakananId,
  }) : super(
          id: id,
          nama: nama,
          deskripsi: deskripsi,
          harga: harga,
          kategoriMakananId: kategoriMakananId,
        );

  factory MakananModel.fromJson(Map<String, dynamic> json) {
  return MakananModel(
    id: json['id'],
    nama: json['nama'],
    deskripsi: json['deskripsi'] ?? '',
    harga: json['harga'] is String
        ? double.tryParse(json['harga']) ?? 0.0
        : (json['harga'] as num).toDouble(),
    kategoriMakananId: json['kategori_makanan_id'],
  );
}

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'deskripsi': deskripsi,
      'harga': harga,
      'kategori_makanan_id': kategoriMakananId,
    };
  }
}
