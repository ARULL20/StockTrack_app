// lib/features/barang_keluar/presentation/bloc/barang_keluar_state.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/barang_keluar.dart';

abstract class BarangKeluarState extends Equatable {
  const BarangKeluarState();

  @override
  List<Object?> get props => [];
}

class BarangKeluarInitial extends BarangKeluarState {}

class BarangKeluarLoading extends BarangKeluarState {}

class BarangKeluarLoaded extends BarangKeluarState {
  final List<BarangKeluar> list;

  const BarangKeluarLoaded(this.list);

  @override
  List<Object?> get props => [list];
}

class BarangKeluarSuccess extends BarangKeluarState {}

class BarangKeluarError extends BarangKeluarState {
  final String message;

  const BarangKeluarError(this.message);

  @override
  List<Object?> get props => [message];
}
