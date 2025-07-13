import 'package:stoktrack_app/features/makanan/domain/entities/makanan_entity.dart';
import '../repositories/makanan_repository.dart';

class GetAllMakanan {
  final MakananRepository repository;

  GetAllMakanan(this.repository);

  Future<List<Makanan>> call() async {
    return await repository.getAllMakanan();
  }
}
