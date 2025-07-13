import 'package:equatable/equatable.dart';

abstract class BarangKeluarEvent extends Equatable {
  const BarangKeluarEvent();

  @override
  List<Object?> get props => [];
}

class GetAllBarangKeluarEvent extends BarangKeluarEvent {}

class CreateBarangKeluarEvent extends BarangKeluarEvent {
  final Map<String, dynamic> data;

  const CreateBarangKeluarEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class UpdateBarangKeluarEvent extends BarangKeluarEvent {
  final int id;
  final Map<String, dynamic> data;

  const UpdateBarangKeluarEvent(this.id, this.data);

  @override
  List<Object?> get props => [id, data];
}

class DeleteBarangKeluarEvent extends BarangKeluarEvent {
  final int id;

  const DeleteBarangKeluarEvent(this.id);

  @override
  List<Object?> get props => [id];
}
