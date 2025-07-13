import 'package:stoktrack_app/features/barang/domain/entities/barang.dart';

class BarangKeluar {
  final int id;
  final int barangId;
  final int jumlah;
  final double harga;
  final String? keterangan;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Barang barang; 

  BarangKeluar({
    required this.id,
    required this.barangId,
    required this.jumlah,
    required this.harga,
    this.keterangan,
    required this.createdAt,
    required this.updatedAt,
    required this.barang, 
  });
}
