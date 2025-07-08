class KategoriBarangEntity {
  final int id;
  final String nama;
  final String? deskripsi;

  KategoriBarangEntity({
    required this.id,
    required this.nama,
    this.deskripsi,
  });
}
