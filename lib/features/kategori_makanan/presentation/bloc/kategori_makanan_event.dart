import 'package:equatable/equatable.dart';

abstract class KategoriMakananEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchKategoriMakanan extends KategoriMakananEvent {}

class CreateKategoriMakananEvent extends KategoriMakananEvent {
  final Map<String, dynamic> data;
  CreateKategoriMakananEvent(this.data);
}

class UpdateKategoriMakananEvent extends KategoriMakananEvent {
  final int id;
  final Map<String, dynamic> data;
  UpdateKategoriMakananEvent(this.id, this.data);
}

class DeleteKategoriMakananEvent extends KategoriMakananEvent {
  final int id;
  DeleteKategoriMakananEvent(this.id);
}
