// lib/features/barang/domain/entities/barang.dart

class Barang {
  final int id;
  final String nama;
  final String? deskripsi;
  final String? gambar;
  final int stok;
  final double harga;
  final int kategoriBarangId;
  final int gudangId;

  Barang({
    required this.id,
    required this.nama,
    this.deskripsi,
    this.gambar,
    required this.stok,
    required this.harga,
    required this.kategoriBarangId,
    required this.gudangId,
  });
}
