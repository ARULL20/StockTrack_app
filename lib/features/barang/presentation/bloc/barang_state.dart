// lib/features/barang/presentation/bloc/barang_state.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/barang.dart';

abstract class BarangState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BarangInitial extends BarangState {}

class BarangLoading extends BarangState {}

class BarangLoaded extends BarangState {
  final List<Barang> barangList;

  BarangLoaded(this.barangList);

  @override
  List<Object?> get props => [barangList];
}

class BarangOperationSuccess extends BarangState {
  final String message;

  BarangOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class BarangError extends BarangState {
  final String error;

  BarangError(this.error);

  @override
  List<Object?> get props => [error];
}
