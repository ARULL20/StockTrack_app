import 'package:equatable/equatable.dart';
import 'package:stoktrack_app/features/makanan/domain/entities/makanan_entity.dart';

abstract class MakananState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MakananInitial extends MakananState {}

class MakananLoading extends MakananState {}

class MakananLoaded extends MakananState {
  final List<Makanan> makananList;

  MakananLoaded(this.makananList);

  @override
  List<Object?> get props => [makananList];
}

class MakananOperationSuccess extends MakananState {
  final String message;

  MakananOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class MakananError extends MakananState {
  final String error;

  MakananError(this.error);

  @override
  List<Object?> get props => [error];
}
