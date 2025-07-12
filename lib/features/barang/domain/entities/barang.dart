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

  String? get gambarUrl {
    if (gambar == null) return null;
    return 'http://10.0.2.2:8000/storage/$gambar';
  }
}
