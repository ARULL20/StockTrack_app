import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_all_kategori_makanan.dart';
import '../../domain/usecases/create_kategori_makanan.dart';
import '../../domain/usecases/update_kategori_makanan.dart';
import '../../domain/usecases/delete_kategori_makanan.dart';

import 'kategori_makanan_event.dart';
import 'kategori_makanan_state.dart';

class KategoriMakananBloc extends Bloc<KategoriMakananEvent, KategoriMakananState> {
  final GetAllKategoriMakanan getAll;
  final CreateKategoriMakanan create;
  final UpdateKategoriMakanan update;
  final DeleteKategoriMakanan delete;

  KategoriMakananBloc({
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  }) : super(KategoriMakananInitial()) {
    on<FetchKategoriMakanan>((event, emit) async {
      emit(KategoriMakananLoading());
      try {
        final result = await getAll();
        emit(KategoriMakananLoaded(result));
      } catch (e) {
        emit(KategoriMakananError(e.toString()));
      }
    });

    on<CreateKategoriMakananEvent>((event, emit) async {
      await create(event.data);
      add(FetchKategoriMakanan());
    });

    on<UpdateKategoriMakananEvent>((event, emit) async {
      await update(event.id, event.data);
      add(FetchKategoriMakanan());
    });

    on<DeleteKategoriMakananEvent>((event, emit) async {
      await delete(event.id);
      add(FetchKategoriMakanan());
    });
  }
}
