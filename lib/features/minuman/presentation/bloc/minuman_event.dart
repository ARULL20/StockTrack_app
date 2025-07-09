import '../../domain/entities/minuman_entity.dart';

abstract class MinumanEvent {}

class GetAllMinumanEvent extends MinumanEvent {}

class CreateMinumanEvent extends MinumanEvent {
  final MinumanEntity minuman;
  CreateMinumanEvent(this.minuman);
}

class UpdateMinumanEvent extends MinumanEvent {
  final MinumanEntity minuman;
  UpdateMinumanEvent(this.minuman);
}

class DeleteMinumanEvent extends MinumanEvent {
  final int id;
  DeleteMinumanEvent(this.id);
}
