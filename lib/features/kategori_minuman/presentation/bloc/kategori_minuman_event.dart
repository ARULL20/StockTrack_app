import 'package:equatable/equatable.dart';

abstract class KategoriMinumanEvent extends Equatable {
  const KategoriMinumanEvent();

  @override
  List<Object?> get props => [];
}

class GetAllKategoriMinumanEvent extends KategoriMinumanEvent {}

class CreateKategoriMinumanEvent extends KategoriMinumanEvent {
  final Map<String, dynamic> data;

  const CreateKategoriMinumanEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class UpdateKategoriMinumanEvent extends KategoriMinumanEvent {
  final int id;
  final Map<String, dynamic> data;

  const UpdateKategoriMinumanEvent(this.id, this.data);

  @override
  List<Object?> get props => [id, data];
}

class DeleteKategoriMinumanEvent extends KategoriMinumanEvent {
  final int id;

  const DeleteKategoriMinumanEvent(this.id);

  @override
  List<Object?> get props => [id];
}
