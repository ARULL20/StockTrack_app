import 'package:equatable/equatable.dart';

abstract class LaporanEvent extends Equatable {
  const LaporanEvent();

  @override
  List<Object?> get props => [];
}

class LoadPemasukan extends LaporanEvent {}

class LoadPengeluaran extends LaporanEvent {}
