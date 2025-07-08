import '../../domain/entities/gudang_entity.dart';

class GudangModel extends GudangEntity {
  GudangModel({
    required int id,
    required String nama,
    String? lokasi,
    String? deskripsi,
  }) : super(
          id: id,
          nama: nama,
          lokasi: lokasi,
          deskripsi: deskripsi,
        );

  factory GudangModel.fromJson(Map<String, dynamic> json) {
    return GudangModel(
      id: json['id'],
      nama: json['nama'],
      lokasi: json['lokasi'],
      deskripsi: json['deskripsi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'lokasi': lokasi,
      'deskripsi': deskripsi,
    };
  }
}
