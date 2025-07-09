import '../../domain/entities/makanan_entity.dart';

abstract class MakananState {}

class MakananInitial extends MakananState {}

class MakananLoading extends MakananState {}

class MakananLoaded extends MakananState {
  final List<MakananEntity> listMakanan;
  MakananLoaded(this.listMakanan);
}

class MakananSuccess extends MakananState {}

class MakananFailure extends MakananState {
  final String message;
  MakananFailure(this.message);
}
