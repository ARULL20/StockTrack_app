import '../../domain/entities/minuman_entity.dart';

abstract class MinumanState {}

class MinumanInitial extends MinumanState {}

class MinumanLoading extends MinumanState {}

class MinumanLoaded extends MinumanState {
  final List<MinumanEntity> listMinuman;
  MinumanLoaded(this.listMinuman);
}

class MinumanFailure extends MinumanState {
  final String message;
  MinumanFailure(this.message);
}
