
import 'package:stoktrack_app/features/kategori_minuman/domain/repositories/kategori_minuman_repository.dart';

class UpdateKategoriMinuman {
  final KategoriMinumanRepository repository;

  UpdateKategoriMinuman(this.repository);

  Future<void> call(int id, Map<String, dynamic> data) {
    return repository.update(id, data);
  }
}
