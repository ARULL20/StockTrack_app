import 'package:equatable/equatable.dart';

abstract class LaporanEvent extends Equatable {
  const LaporanEvent();

  @override
  List<Object?> get props => [];
}

class LoadPemasukan extends LaporanEvent {}
class LoadPengeluaran extends LaporanEvent {}

// 🔽 Tambah event baru
class ExportPemasukanPDF extends LaporanEvent {}

class ExportPengeluaranPDF extends LaporanEvent {}
