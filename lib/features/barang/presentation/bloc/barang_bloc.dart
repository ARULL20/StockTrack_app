// lib/features/barang/presentation/bloc/barang_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'barang_event.dart';
import 'barang_state.dart';
import '../../domain/usecases/get_all_barang.dart';
import '../../domain/usecases/create_barang.dart';
import '../../domain/usecases/update_barang.dart';
import '../../domain/usecases/delete_barang.dart';
import '../../domain/usecases/upload_gambar_barang.dart';

class BarangBloc extends Bloc<BarangEvent, BarangState> {
  final GetAllBarang getAllBarang;
  final CreateBarang createBarang;
  final UpdateBarang updateBarang;
  final DeleteBarang deleteBarang;
  final UploadGambarBarang uploadGambarBarang;

  BarangBloc({
    required this.getAllBarang,
    required this.createBarang,
    required this.updateBarang,
    required this.deleteBarang,
    required this.uploadGambarBarang,
  }) : super(BarangInitial()) {
    on<FetchBarang>(_onFetchBarang);
    on<CreateBarangEvent>(_onCreateBarang);
    on<UpdateBarangEvent>(_onUpdateBarang);
    on<DeleteBarangEvent>(_onDeleteBarang);
    on<UploadGambarEvent>(_onUploadGambar);
  }

  Future<void> _onFetchBarang(FetchBarang event, Emitter<BarangState> emit) async {
    emit(BarangLoading());
    try {
      final barangList = await getAllBarang();
      emit(BarangLoaded(barangList));
    } catch (e) {
      emit(BarangError(e.toString()));
    }
  }

  Future<void> _onCreateBarang(CreateBarangEvent event, Emitter<BarangState> emit) async {
    emit(BarangLoading());
    try {
      await createBarang(event.data);
      emit(BarangOperationSuccess('Barang berhasil dibuat'));
      add(FetchBarang()); // refresh list
    } catch (e) {
      emit(BarangError(e.toString()));
    }
  }

  Future<void> _onUpdateBarang(UpdateBarangEvent event, Emitter<BarangState> emit) async {
    emit(BarangLoading());
    try {
      await updateBarang(event.id, event.data);
      emit(BarangOperationSuccess('Barang berhasil diperbarui'));
      add(FetchBarang());
    } catch (e) {
      emit(BarangError(e.toString()));
    }
  }

  Future<void> _onDeleteBarang(DeleteBarangEvent event, Emitter<BarangState> emit) async {
    emit(BarangLoading());
    try {
      await deleteBarang(event.id);
      emit(BarangOperationSuccess('Barang berhasil dihapus'));
      add(FetchBarang());
    } catch (e) {
      emit(BarangError(e.toString()));
    }
  }

  Future<void> _onUploadGambar(UploadGambarEvent event, Emitter<BarangState> emit) async {
    emit(BarangLoading());
    try {
      await uploadGambarBarang(event.id, event.gambar);
      emit(BarangOperationSuccess('Gambar berhasil diupload'));
      add(FetchBarang());
    } catch (e) {
      emit(BarangError(e.toString()));
    }
  }
}
