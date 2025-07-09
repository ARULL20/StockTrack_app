import 'package:flutter_bloc/flutter_bloc.dart';
import 'kategori_minuman_event.dart';
import 'kategori_minuman_state.dart';
import '../../domain/usecases/get_all_kategori_minuman.dart';
import '../../domain/usecases/create_kategori_minuman.dart';
import '../../domain/usecases/update_kategori_minuman.dart';
import '../../domain/usecases/delete_kategori_minuman.dart';

class KategoriMinumanBloc extends Bloc<KategoriMinumanEvent, KategoriMinumanState> {
  final GetAllKategoriMinuman getAll;
  final CreateKategoriMinuman create;
  final UpdateKategoriMinuman update;
  final DeleteKategoriMinuman delete;

  KategoriMinumanBloc({
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  }) : super(KategoriMinumanInitial()) {
    on<GetAllKategoriMinumanEvent>((event, emit) async {
      emit(KategoriMinumanLoading());
      try {
        final result = await getAll();
        emit(KategoriMinumanLoaded(result));
      } catch (e) {
        emit(KategoriMinumanError(e.toString()));
      }
    });

    on<CreateKategoriMinumanEvent>((event, emit) async {
      emit(KategoriMinumanLoading());
      try {
        await create(event.data);
        final result = await getAll(); // REFRESH!
        emit(KategoriMinumanLoaded(result));
      } catch (e) {
        emit(KategoriMinumanError(e.toString()));
      }
    });

    on<UpdateKategoriMinumanEvent>((event, emit) async {
      emit(KategoriMinumanLoading());
      try {
        await update(event.id, event.data);
        final result = await getAll(); // REFRESH!
        emit(KategoriMinumanLoaded(result));
      } catch (e) {
        emit(KategoriMinumanError(e.toString()));
      }
    });

    on<DeleteKategoriMinumanEvent>((event, emit) async {
      emit(KategoriMinumanLoading());
      try {
        await delete(event.id);
        final result = await getAll(); // REFRESH!
        emit(KategoriMinumanLoaded(result));
      } catch (e) {
        emit(KategoriMinumanError(e.toString()));
      }
    });
  }
}
