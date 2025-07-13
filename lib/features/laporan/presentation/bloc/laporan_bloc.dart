import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:stoktrack_app/features/laporan/domain/repositories/laporan_repository.dart';
import 'package:stoktrack_app/features/laporan/domain/usecase/get_pemasukan_total.dart';
import 'package:stoktrack_app/features/laporan/domain/usecase/get_pengeluaran_total.dart';
import 'package:stoktrack_app/features/laporan/presentation/bloc/laporan_event.dart';
import 'package:stoktrack_app/features/laporan/presentation/bloc/laporan_state.dart';

class LaporanBloc extends Bloc<LaporanEvent, LaporanState> {
  final GetPemasukanTotal getPemasukanTotal;
  final GetPengeluaranTotal getPengeluaranTotal;
  final LaporanRepository laporanRepository; // ⬅️ Tambah ini

  LaporanBloc({
    required this.getPemasukanTotal,
    required this.getPengeluaranTotal,
    required this.laporanRepository, // ⬅️ Tambah ini
  }) : super(LaporanInitial()) {
    on<LoadPemasukan>((event, emit) async {
      emit(LaporanLoading());
      try {
        final pemasukan = await getPemasukanTotal();
        final pengeluaran = await getPengeluaranTotal();
        emit(LaporanLoaded(
          totalPemasukan: pemasukan,
          totalPengeluaran: pengeluaran,
        ));
      } catch (e) {
        emit(LaporanError(e.toString()));
      }
    });

    // 🔽 Tambah handler export pemasukan
    on<ExportPemasukanPDF>((event, emit) async {
      try {
        final file = await laporanRepository.downloadPemasukanPDF();
        await OpenFile.open(file.path);
        emit(ExportPDFSuccess());
      } catch (e) {
        emit(LaporanError(e.toString()));
      }
    });

    // 🔽 Tambah handler export pengeluaran
    on<ExportPengeluaranPDF>((event, emit) async {
      try {
        final file = await laporanRepository.downloadPengeluaranPDF();
        await OpenFile.open(file.path);
        emit(ExportPDFSuccess());
      } catch (e) {
        emit(LaporanError(e.toString()));
      }
    });
  }
}
