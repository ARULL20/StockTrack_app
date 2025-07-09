class MinumanEntity {
  final int id;
  final String nama;
  final String? deskripsi;
  final double harga;
  final int kategoriMinumanId;

  const MinumanEntity({
    required this.id,
    required this.nama,
    this.deskripsi,
    required this.harga,
    required this.kategoriMinumanId,
  });
}
