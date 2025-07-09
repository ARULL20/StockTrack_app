import 'package:stoktrack_app/features/barang/domain/entities/barang.dart';
import 'package:stoktrack_app/features/barang/data/models/barang_model.dart';
import 'package:stoktrack_app/features/barang_keluar/domain/entities/barang_keluar.dart';

class BarangKeluarModel extends BarangKeluar {
  BarangKeluarModel({
    required int id,
    required int barangId,
    required int jumlah,
    required double harga,
    String? keterangan,
    required DateTime createdAt,
    required DateTime updatedAt,
    required Barang barang, 
  }) : super(
          id: id,
          barangId: barangId,
          jumlah: jumlah,
          harga: harga,
          keterangan: keterangan,
          createdAt: createdAt,
          updatedAt: updatedAt,
          barang: barang, 
        );

  factory BarangKeluarModel.fromJson(Map<String, dynamic> json) {
    return BarangKeluarModel(
      id: json['id'],
      barangId: json['barang_id'],
      jumlah: json['jumlah'],
      harga: double.parse(json['harga'].toString()),
      keterangan: json['keterangan'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      barang: BarangModel.fromJson(json['barang']), // ✅ mapping barang
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'barang_id': barangId,
      'jumlah': jumlah,
      'harga': harga,
      'keterangan': keterangan,
    };
  }
}
