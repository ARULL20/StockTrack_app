class Makanan {
  final int id;
  final String nama;
  final String? deskripsi;
  final double harga;
  final int kategoriMakananId;
  final String? gambar;

  Makanan({
    required this.id,
    required this.nama,
    this.deskripsi,
    required this.harga,
    required this.kategoriMakananId,
    this.gambar,
  });

  String? get gambarUrl {
    if (gambar == null) return null;
    return 'http://10.0.2.2:8000/storage/$gambar';
  }
}
