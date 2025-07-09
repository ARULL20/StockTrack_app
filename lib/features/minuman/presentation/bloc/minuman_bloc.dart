import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_all_minuman.dart';
import '../../domain/usecases/create_minuman.dart';
import '../../domain/usecases/update_minuman.dart';
import '../../domain/usecases/delete_minuman.dart';

import 'minuman_event.dart';
import 'minuman_state.dart';

class MinumanBloc extends Bloc<MinumanEvent, MinumanState> {
  final GetAllMinuman getAll;
  final CreateMinuman create;
  final UpdateMinuman update;
  final DeleteMinuman delete;

  MinumanBloc({
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  }) : super(MinumanInitial()) {
    on<GetAllMinumanEvent>((event, emit) async {
      emit(MinumanLoading());
      try {
        final list = await getAll();
        emit(MinumanLoaded(list));
      } catch (e) {
        emit(MinumanFailure(e.toString()));
      }
    });

    on<CreateMinumanEvent>((event, emit) async {
      emit(MinumanLoading());
      try {
        await create(event.minuman);
        final list = await getAll(); // refresh!
        emit(MinumanLoaded(list));
      } catch (e) {
        emit(MinumanFailure(e.toString()));
      }
    });

    on<UpdateMinumanEvent>((event, emit) async {
      emit(MinumanLoading());
      try {
        await update(event.minuman);
        final list = await getAll(); // refresh!
        emit(MinumanLoaded(list));
      } catch (e) {
        emit(MinumanFailure(e.toString()));
      }
    });

    on<DeleteMinumanEvent>((event, emit) async {
      emit(MinumanLoading());
      try {
        await delete(event.id);
        final list = await getAll(); // refresh!
        emit(MinumanLoaded(list));
      } catch (e) {
        emit(MinumanFailure(e.toString()));
      }
    });
  }
}
