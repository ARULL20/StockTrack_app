import '../../domain/entities/makanan_entity.dart';

abstract class MakananEvent {}

class GetAllMakananEvent extends MakananEvent {}

class CreateMakananEvent extends MakananEvent {
  final MakananEntity makanan;
  CreateMakananEvent(this.makanan);
}

class UpdateMakananEvent extends MakananEvent {
  final MakananEntity makanan;
  UpdateMakananEvent(this.makanan);
}

class DeleteMakananEvent extends MakananEvent {
  final int id;
  DeleteMakananEvent(this.id);
}
