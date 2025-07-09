import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_all_makanan.dart';
import '../../domain/usecases/create_makanan.dart';
import '../../domain/usecases/update_makanan.dart';
import '../../domain/usecases/delete_makanan.dart';

import 'makanan_event.dart';
import 'makanan_state.dart';

class MakananBloc extends Bloc<MakananEvent, MakananState> {
  final GetAllMakanan getAll;
  final CreateMakanan create;
  final UpdateMakanan update;
  final DeleteMakanan delete;

  MakananBloc({
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  }) : super(MakananInitial()) {
    on<GetAllMakananEvent>((event, emit) async {
      emit(MakananLoading());
      try {
        final list = await getAll();
        emit(MakananLoaded(list));
      } catch (e) {
        emit(MakananFailure(e.toString()));
      }
    });

    on<CreateMakananEvent>((event, emit) async {
      emit(MakananLoading());
      try {
        await create(event.makanan);
        final list = await getAll(); // langsung reload
        emit(MakananLoaded(list));
      } catch (e) {
        emit(MakananFailure(e.toString()));
      }
    });

    on<UpdateMakananEvent>((event, emit) async {
      emit(MakananLoading());
      try {
        await update(event.makanan);
        final list = await getAll(); // langsung reload
        emit(MakananLoaded(list));
      } catch (e) {
        emit(MakananFailure(e.toString()));
      }
    });

    on<DeleteMakananEvent>((event, emit) async {
      emit(MakananLoading());
      try {
        await delete(event.id);
        final list = await getAll(); // langsung reload
        emit(MakananLoaded(list));
      } catch (e) {
        emit(MakananFailure(e.toString()));
      }
    });
  }
}
