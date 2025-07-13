import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'makanan_event.dart';
import 'makanan_state.dart';

import '../../domain/usecases/get_all_makanan.dart';
import '../../domain/usecases/create_makanan.dart';
import '../../domain/usecases/update_makanan.dart';
import '../../domain/usecases/delete_makanan.dart';
import '../../domain/usecases/upload_gambar_makanan.dart';

class MakananBloc extends Bloc<MakananEvent, MakananState> {
  final GetAllMakanan getAllMakanan;
  final CreateMakanan createMakanan;
  final UpdateMakanan updateMakanan;
  final DeleteMakanan deleteMakanan;
  final UploadGambarMakanan uploadGambarMakanan;

  MakananBloc({
    required this.getAllMakanan,
    required this.createMakanan,
    required this.updateMakanan,
    required this.deleteMakanan,
    required this.uploadGambarMakanan,
  }) : super(MakananInitial()) {
    on<FetchMakanan>(_onFetchMakanan);
    on<CreateMakananEvent>(_onCreateMakanan);
    on<UpdateMakananEvent>(_onUpdateMakanan);
    on<DeleteMakananEvent>(_onDeleteMakanan);
    on<UploadGambarMakananEvent>(_onUploadGambarMakanan);
  }

  Future<void> _onFetchMakanan(FetchMakanan event, Emitter<MakananState> emit) async {
    emit(MakananLoading());
    try {
      final list = await getAllMakanan();
      emit(MakananLoaded(list));
    } catch (e) {
      emit(MakananError(e.toString()));
    }
  }

  Future<void> _onCreateMakanan(CreateMakananEvent event, Emitter<MakananState> emit) async {
    emit(MakananLoading());
    try {
      final id = await createMakanan(event.data);
      if (event.gambar != null) {
        await uploadGambarMakanan(id, event.gambar!);
      }
      emit(MakananOperationSuccess('Makanan berhasil dibuat'));
      add(FetchMakanan());
    } catch (e) {
      emit(MakananError(e.toString()));
    }
  }

  Future<void> _onUpdateMakanan(UpdateMakananEvent event, Emitter<MakananState> emit) async {
    emit(MakananLoading());
    try {
      await updateMakanan(event.id, event.data);
      emit(MakananOperationSuccess('Makanan berhasil diperbarui'));
      add(FetchMakanan());
    } catch (e) {
      emit(MakananError(e.toString()));
    }
  }

  Future<void> _onDeleteMakanan(DeleteMakananEvent event, Emitter<MakananState> emit) async {
    emit(MakananLoading());
    try {
      await deleteMakanan(event.id);
      emit(MakananOperationSuccess('Makanan berhasil dihapus'));
      add(FetchMakanan());
    } catch (e) {
      emit(MakananError(e.toString()));
    }
  }

  Future<void> _onUploadGambarMakanan(UploadGambarMakananEvent event, Emitter<MakananState> emit) async {
    emit(MakananLoading());
    try {
      await uploadGambarMakanan(event.id, event.gambar);
      emit(MakananOperationSuccess('Gambar makanan berhasil diupload'));
      add(FetchMakanan());
    } catch (e) {
      emit(MakananError(e.toString()));
    }
  }
}
