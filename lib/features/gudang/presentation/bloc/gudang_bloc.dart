import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_all_gudang.dart';
import '../../domain/usecase/create_gudang.dart';
import '../../domain/usecase/update_gudang.dart';
import '../../domain/usecase/delete_gudang.dart';
import 'gudang_event.dart';
import 'gudang_state.dart';

class GudangBloc extends Bloc<GudangEvent, GudangState> {
  final GetAllGudang getAll;
  final CreateGudang create;
  final UpdateGudang update;
  final DeleteGudang delete;

  GudangBloc({
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  }) : super(GudangInitial()) {
    on<GetAllGudangEvent>(_onGetAll);
    on<CreateGudangEvent>(_onCreate);
    on<UpdateGudangEvent>(_onUpdate);
    on<DeleteGudangEvent>(_onDelete);
  }

  Future<void> _onGetAll(
    GetAllGudangEvent event,
    Emitter<GudangState> emit,
  ) async {
    emit(GudangLoading());
    try {
      final list = await getAll();
      emit(GudangLoaded(list));
    } catch (e) {
      emit(GudangError(e.toString()));
    }
  }

  Future<void> _onCreate(
    CreateGudangEvent event,
    Emitter<GudangState> emit,
  ) async {
    emit(GudangLoading());
    try {
      await create(event.entity);
      emit(const GudangSuccess('Gudang berhasil ditambahkan'));
    } catch (e) {
      emit(GudangError(e.toString()));
    }
  }

  Future<void> _onUpdate(
    UpdateGudangEvent event,
    Emitter<GudangState> emit,
  ) async {
    emit(GudangLoading());
    try {
      await update(event.id, event.entity);
      emit(const GudangSuccess('Gudang berhasil diupdate'));
    } catch (e) {
      emit(GudangError(e.toString()));
    }
  }

  Future<void> _onDelete(
    DeleteGudangEvent event,
    Emitter<GudangState> emit,
  ) async {
    emit(GudangLoading());
    try {
      await delete(event.id);
      emit(const GudangSuccess('Gudang berhasil dihapus'));
    } catch (e) {
      emit(GudangError(e.toString()));
    }
  }
}
