class MinumanEntity {
  final int id;
  final String nama;
  final String? deskripsi;
  final double harga;
  final int kategoriMinumanId;
  final String? gambar;

  const MinumanEntity({
    required this.id,
    required this.nama,
    this.deskripsi,
    required this.harga,
    required this.kategoriMinumanId,
    this.gambar,
  });

  String? get gambarUrl {
    if (gambar == null) return null;
    return 'http://10.0.2.2:8000/storage/$gambar';
  }
}
