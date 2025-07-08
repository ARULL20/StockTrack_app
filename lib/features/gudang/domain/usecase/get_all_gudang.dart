import '../entities/gudang_entity.dart';
import '../repositories/gudang_repository.dart';

class GetAllGudang {
  final GudangRepository repository;

  GetAllGudang(this.repository);

  Future<List<GudangEntity>> call() => repository.getAll();
}
