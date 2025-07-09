
import 'package:stoktrack_app/features/kategori_minuman/domain/repositories/kategori_minuman_repository.dart';

class DeleteKategoriMinuman {
  final KategoriMinumanRepository repository;

  DeleteKategoriMinuman(this.repository);

  Future<void> call(int id) {
    return repository.delete(id);
  }
}
