import 'package:equatable/equatable.dart';
import '../../domain/entities/minuman_entity.dart';

abstract class MinumanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MinumanInitial extends MinumanState {}

class MinumanLoading extends MinumanState {}

class MinumanLoaded extends MinumanState {
  final List<MinumanEntity> minumanList;

  MinumanLoaded(this.minumanList);

  @override
  List<Object?> get props => [minumanList];
}

class MinumanOperationSuccess extends MinumanState {
  final String message;

  MinumanOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class MinumanError extends MinumanState {
  final String error;

  MinumanError(this.error);

  @override
  List<Object?> get props => [error];
}
