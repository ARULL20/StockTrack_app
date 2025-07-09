import '../../domain/entities/minuman_entity.dart';

class MinumanModel extends MinumanEntity {
  const MinumanModel({
    required int id,
    required String nama,
    String? deskripsi,
    required double harga,
    required int kategoriMinumanId,
  }) : super(
          id: id,
          nama: nama,
          deskripsi: deskripsi,
          harga: harga,
          kategoriMinumanId: kategoriMinumanId,
        );

  factory MinumanModel.fromJson(Map<String, dynamic> json) {
    return MinumanModel(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      harga: double.tryParse(json['harga'].toString()) ?? 0.0,
      kategoriMinumanId: json['kategori_minuman_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'deskripsi': deskripsi,
      'harga': harga,
      'kategori_minuman_id': kategoriMinumanId,
    };
  }
}
