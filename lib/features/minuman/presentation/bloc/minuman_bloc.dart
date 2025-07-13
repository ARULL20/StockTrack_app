import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_all_minuman.dart';
import '../../domain/usecases/create_minuman.dart';
import '../../domain/usecases/update_minuman.dart';
import '../../domain/usecases/delete_minuman.dart';
import '../../domain/usecases/upload_gambar_minuman.dart';

import 'minuman_event.dart';
import 'minuman_state.dart';

class MinumanBloc extends Bloc<MinumanEvent, MinumanState> {
  final GetAllMinuman getAllMinuman;
  final CreateMinuman createMinuman;
  final UpdateMinuman updateMinuman;
  final DeleteMinuman deleteMinuman;
  final UploadGambarMinuman uploadGambarMinuman;

  MinumanBloc({
    required this.getAllMinuman,
    required this.createMinuman,
    required this.updateMinuman,
    required this.deleteMinuman,
    required this.uploadGambarMinuman,
  }) : super(MinumanInitial()) {
    on<FetchMinuman>(_onFetchMinuman);
    on<CreateMinumanEvent>(_onCreateMinuman);
    on<UpdateMinumanEvent>(_onUpdateMinuman);
    on<DeleteMinumanEvent>(_onDeleteMinuman);
    on<UploadGambarMinumanEvent>(_onUploadGambarMinuman);
  }

  Future<void> _onFetchMinuman(FetchMinuman event, Emitter<MinumanState> emit) async {
    emit(MinumanLoading());
    try {
      final list = await getAllMinuman();
      emit(MinumanLoaded(list));
    } catch (e) {
      emit(MinumanError(e.toString()));
    }
  }

  Future<void> _onCreateMinuman(CreateMinumanEvent event, Emitter<MinumanState> emit) async {
    emit(MinumanLoading());
    try {
      final id = await createMinuman(event.data);
      if (event.gambar != null) {
        await uploadGambarMinuman(id, event.gambar!);
      }
      emit(MinumanOperationSuccess('Minuman berhasil dibuat'));
      add(FetchMinuman());
    } catch (e) {
      emit(MinumanError(e.toString()));
    }
  }

  Future<void> _onUpdateMinuman(UpdateMinumanEvent event, Emitter<MinumanState> emit) async {
    emit(MinumanLoading());
    try {
      await updateMinuman(event.id, event.data);
      emit(MinumanOperationSuccess('Minuman berhasil diperbarui'));
      add(FetchMinuman());
    } catch (e) {
      emit(MinumanError(e.toString()));
    }
  }

  Future<void> _onDeleteMinuman(DeleteMinumanEvent event, Emitter<MinumanState> emit) async {
    emit(MinumanLoading());
    try {
      await deleteMinuman(event.id);
      emit(MinumanOperationSuccess('Minuman berhasil dihapus'));
      add(FetchMinuman());
    } catch (e) {
      emit(MinumanError(e.toString()));
    }
  }

  Future<void> _onUploadGambarMinuman(UploadGambarMinumanEvent event, Emitter<MinumanState> emit) async {
    emit(MinumanLoading());
    try {
      await uploadGambarMinuman(event.id, event.gambar);
      emit(MinumanOperationSuccess('Gambar minuman berhasil diupload'));
      add(FetchMinuman());
    } catch (e) {
      emit(MinumanError(e.toString()));
    }
  }
}
