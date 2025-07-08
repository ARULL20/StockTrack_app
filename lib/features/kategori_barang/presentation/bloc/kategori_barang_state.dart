import 'package:equatable/equatable.dart';
import '../../domain/entities/kategori_barang_entity.dart';

abstract class KategoriBarangState extends Equatable {
  const KategoriBarangState();

  @override
  List<Object?> get props => [];
}

class KategoriBarangInitial extends KategoriBarangState {}

class KategoriBarangLoading extends KategoriBarangState {}

class KategoriBarangLoaded extends KategoriBarangState {
  final List<KategoriBarangEntity> list;

  const KategoriBarangLoaded(this.list);

  @override
  List<Object?> get props => [list];
}

class KategoriBarangSuccess extends KategoriBarangState {
  final String message;

  const KategoriBarangSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class KategoriBarangError extends KategoriBarangState {
  final String message;

  const KategoriBarangError(this.message);

  @override
  List<Object?> get props => [message];
}
