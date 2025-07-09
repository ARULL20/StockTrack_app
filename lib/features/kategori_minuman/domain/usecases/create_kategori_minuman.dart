
import 'package:stoktrack_app/features/kategori_minuman/domain/repositories/kategori_minuman_repository.dart';

class CreateKategoriMinuman {
  final KategoriMinumanRepository repository;

  CreateKategoriMinuman(this.repository);

  Future<void> call(Map<String, dynamic> data) {
    return repository.create(data);
  }
}
