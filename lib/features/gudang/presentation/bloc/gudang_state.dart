import 'package:equatable/equatable.dart';
import '../../domain/entities/gudang_entity.dart';

abstract class GudangState extends Equatable {
  const GudangState();

  @override
  List<Object?> get props => [];
}

class GudangInitial extends GudangState {}

class GudangLoading extends GudangState {}

class GudangLoaded extends GudangState {
  final List<GudangEntity> list;

  const GudangLoaded(this.list);

  @override
  List<Object?> get props => [list];
}

class GudangSuccess extends GudangState {
  final String message;

  const GudangSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class GudangError extends GudangState {
  final String message;

  const GudangError(this.message);

  @override
  List<Object?> get props => [message];
}
