import 'package:equatable/equatable.dart';
import '../../domain/entities/gudang_entity.dart';

abstract class GudangEvent extends Equatable {
  const GudangEvent();

  @override
  List<Object?> get props => [];
}

class GetAllGudangEvent extends GudangEvent {}

class CreateGudangEvent extends GudangEvent {
  final GudangEntity entity;

  const CreateGudangEvent(this.entity);

  @override
  List<Object?> get props => [entity];
}

class UpdateGudangEvent extends GudangEvent {
  final int id;
  final GudangEntity entity;

  const UpdateGudangEvent(this.id, this.entity);

  @override
  List<Object?> get props => [id, entity];
}

class DeleteGudangEvent extends GudangEvent {
  final int id;

  const DeleteGudangEvent(this.id);

  @override
  List<Object?> get props => [id];
}
