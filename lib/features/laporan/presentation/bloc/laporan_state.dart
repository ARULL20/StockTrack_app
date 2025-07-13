import 'package:equatable/equatable.dart';

abstract class LaporanState extends Equatable {
  const LaporanState();

  @override
  List<Object?> get props => [];
}

class LaporanInitial extends LaporanState {}

class LaporanLoading extends LaporanState {}

class LaporanLoaded extends LaporanState {
  final double totalPemasukan;
  final double totalPengeluaran;

  const LaporanLoaded({
    required this.totalPemasukan,
    required this.totalPengeluaran,
  });

  @override
  List<Object?> get props => [totalPemasukan, totalPengeluaran];
}

class LaporanError extends LaporanState {
  final String message;

  const LaporanError(this.message);

  @override
  List<Object?> get props => [message];
}

// 🔽 Tambah state untuk success export
class ExportPDFSuccess extends LaporanState {}
