import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stoktrack_app/features/kategori_barang/domain/usecase/create_kategori_barang.dart';
import 'package:stoktrack_app/features/kategori_barang/domain/usecase/delete_kategori_barang.dart';
import 'package:stoktrack_app/features/kategori_barang/domain/usecase/get_all_kategori_barang.dart';
import 'package:stoktrack_app/features/kategori_barang/domain/usecase/update_kategori_barang.dart';

import 'kategori_barang_event.dart';
import 'kategori_barang_state.dart';

class KategoriBarangBloc extends Bloc<KategoriBarangEvent, KategoriBarangState> {
  final GetAllKategoriBarang getAll;
  final CreateKategoriBarang create;
  final UpdateKategoriBarang update;
  final DeleteKategoriBarang delete;

  KategoriBarangBloc({
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  }) : super(KategoriBarangInitial()) {
    on<GetAllKategoriBarangEvent>(_onGetAll);
    on<CreateKategoriBarangEvent>(_onCreate);
    on<UpdateKategoriBarangEvent>(_onUpdate);
    on<DeleteKategoriBarangEvent>(_onDelete);
  }

  Future<void> _onGetAll(
    GetAllKategoriBarangEvent event,
    Emitter<KategoriBarangState> emit,
  ) async {
    emit(KategoriBarangLoading());
    try {
      final list = await getAll();
      emit(KategoriBarangLoaded(list));
    } catch (e) {
      emit(KategoriBarangError(e.toString()));
    }
  }

  Future<void> _onCreate(
    CreateKategoriBarangEvent event,
    Emitter<KategoriBarangState> emit,
  ) async {
    emit(KategoriBarangLoading());
    try {
      await create(event.entity);
      emit(const KategoriBarangSuccess('Berhasil menambah kategori'));
    } catch (e) {
      emit(KategoriBarangError(e.toString()));
    }
  }

  Future<void> _onUpdate(
    UpdateKategoriBarangEvent event,
    Emitter<KategoriBarangState> emit,
  ) async {
    emit(KategoriBarangLoading());
    try {
      await update(event.id, event.entity);
      emit(const KategoriBarangSuccess('Berhasil update kategori'));
    } catch (e) {
      emit(KategoriBarangError(e.toString()));
    }
  }

  Future<void> _onDelete(
    DeleteKategoriBarangEvent event,
    Emitter<KategoriBarangState> emit,
  ) async {
    emit(KategoriBarangLoading());
    try {
      await delete(event.id);
      emit(const KategoriBarangSuccess('Berhasil hapus kategori'));
    } catch (e) {
      emit(KategoriBarangError(e.toString()));
    }
  }
}
