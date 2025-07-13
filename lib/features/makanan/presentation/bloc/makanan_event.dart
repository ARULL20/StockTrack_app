import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class MakananEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMakanan extends MakananEvent {}

class CreateMakananEvent extends MakananEvent {
  final Map<String, dynamic> data;
  final File? gambar;

  CreateMakananEvent(this.data, {this.gambar});

  @override
  List<Object?> get props => [data, gambar];
}

class UpdateMakananEvent extends MakananEvent {
  final int id;
  final Map<String, dynamic> data;

  UpdateMakananEvent(this.id, this.data);

  @override
  List<Object?> get props => [id, data];
}

class DeleteMakananEvent extends MakananEvent {
  final int id;

  DeleteMakananEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UploadGambarMakananEvent extends MakananEvent {
  final int id;
  final File gambar;

  UploadGambarMakananEvent(this.id, this.gambar);

  @override
  List<Object?> get props => [id, gambar];
}
