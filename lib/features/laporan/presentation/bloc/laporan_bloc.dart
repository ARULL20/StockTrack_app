import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stoktrack_app/features/laporan/domain/usecase/get_pemasukan_total.dart';
import 'package:stoktrack_app/features/laporan/domain/usecase/get_pengeluaran_total.dart';
import 'laporan_event.dart';
import 'laporan_state.dart';

class LaporanBloc extends Bloc<LaporanEvent, LaporanState> {
  final GetPemasukanTotal getPemasukanTotal;
  final GetPengeluaranTotal getPengeluaranTotal;

  LaporanBloc({
    required this.getPemasukanTotal,
    required this.getPengeluaranTotal,
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
  }
}
