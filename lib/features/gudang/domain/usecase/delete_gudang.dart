import '../repositories/gudang_repository.dart';

class DeleteGudang {
  final GudangRepository repository;

  DeleteGudang(this.repository);

  Future<void> call(int id) => repository.delete(id);
}
