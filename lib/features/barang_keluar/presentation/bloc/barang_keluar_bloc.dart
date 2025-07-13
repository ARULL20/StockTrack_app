import 'package:flutter_bloc/flutter_bloc.dart';
import 'barang_keluar_event.dart';
import 'barang_keluar_state.dart';
import '../../domain/usecases/create_barang_keluar.dart';
import '../../domain/usecases/delete_barang_keluar.dart';
import '../../domain/usecases/get_all_barang_keluar.dart';
import '../../domain/usecases/update_barang_keluar.dart';

class BarangKeluarBloc extends Bloc<BarangKeluarEvent, BarangKeluarState> {
  final GetAllBarangKeluar getAll;
  final CreateBarangKeluar create;
  final UpdateBarangKeluar update;
  final DeleteBarangKeluar delete;

  BarangKeluarBloc({
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  }) : super(BarangKeluarInitial()) {
    on<GetAllBarangKeluarEvent>((event, emit) async {
      emit(BarangKeluarLoading());
      try {
        final result = await getAll();
        emit(BarangKeluarLoaded(result));
      } catch (e) {
        emit(BarangKeluarError(e.toString()));
      }
    });

    on<CreateBarangKeluarEvent>((event, emit) async {
      emit(BarangKeluarLoading());
      try {
        await create(event.data);
        emit(BarangKeluarSuccess());
      } catch (e) {
        emit(BarangKeluarError(e.toString()));
      }
    });

    on<UpdateBarangKeluarEvent>((event, emit) async {
      emit(BarangKeluarLoading());
      try {
        await update(event.id, event.data);
        emit(BarangKeluarSuccess());
      } catch (e) {
        emit(BarangKeluarError(e.toString()));
      }
    });

    on<DeleteBarangKeluarEvent>((event, emit) async {
      emit(BarangKeluarLoading());
      try {
        await delete(event.id);
        emit(BarangKeluarSuccess());
      } catch (e) {
        emit(BarangKeluarError(e.toString()));
      }
    });
  }
}
