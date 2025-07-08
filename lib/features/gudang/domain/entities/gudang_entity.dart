class GudangEntity {
  final int id;
  final String nama;
  final String? lokasi;
  final String? deskripsi;

  GudangEntity({
    required this.id,
    required this.nama,
    this.lokasi,
    this.deskripsi,
  });
}
