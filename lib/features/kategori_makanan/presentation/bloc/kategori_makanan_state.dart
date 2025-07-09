import 'package:equatable/equatable.dart';
import '../../domain/entities/kategori_makanan.dart';

abstract class KategoriMakananState extends Equatable {
  @override
  List<Object?> get props => [];
}

class KategoriMakananInitial extends KategoriMakananState {}

class KategoriMakananLoading extends KategoriMakananState {}

class KategoriMakananLoaded extends KategoriMakananState {
  final List<KategoriMakanan> list;
  KategoriMakananLoaded(this.list);
}

class KategoriMakananError extends KategoriMakananState {
  final String message;
  KategoriMakananError(this.message);
}
