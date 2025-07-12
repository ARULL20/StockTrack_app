class GudangEntity {
  final int id;
  final String nama;
  final String? lokasi;
  final String? deskripsi;
  final double? latitude;
  final double? longitude;

  GudangEntity({
    required this.id,
    required this.nama,
    this.lokasi,
    this.deskripsi,
    this.latitude,
    this.longitude,
  });
}
