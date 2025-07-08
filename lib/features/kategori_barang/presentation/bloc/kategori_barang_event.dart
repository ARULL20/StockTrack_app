import 'package:equatable/equatable.dart';
import '../../domain/entities/kategori_barang_entity.dart';

abstract class KategoriBarangEvent extends Equatable {
  const KategoriBarangEvent();

  @override
  List<Object?> get props => [];
}

class GetAllKategoriBarangEvent extends KategoriBarangEvent {}

class CreateKategoriBarangEvent extends KategoriBarangEvent {
  final KategoriBarangEntity entity;

  const CreateKategoriBarangEvent(this.entity);

  @override
  List<Object?> get props => [entity];
}

class UpdateKategoriBarangEvent extends KategoriBarangEvent {
  final int id;
  final KategoriBarangEntity entity;

  const UpdateKategoriBarangEvent(this.id, this.entity);

  @override
  List<Object?> get props => [id, entity];
}

class DeleteKategoriBarangEvent extends KategoriBarangEvent {
  final int id;

  const DeleteKategoriBarangEvent(this.id);

  @override
  List<Object?> get props => [id];
}
