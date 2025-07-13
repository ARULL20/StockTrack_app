import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class MinumanEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMinuman extends MinumanEvent {}

class CreateMinumanEvent extends MinumanEvent {
  final Map<String, dynamic> data;
  final File? gambar;

  CreateMinumanEvent(this.data, {this.gambar});

  @override
  List<Object?> get props => [data, gambar];
}

class UpdateMinumanEvent extends MinumanEvent {
  final int id;
  final Map<String, dynamic> data;

  UpdateMinumanEvent(this.id, this.data);

  @override
  List<Object?> get props => [id, data];
}

class DeleteMinumanEvent extends MinumanEvent {
  final int id;

  DeleteMinumanEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UploadGambarMinumanEvent extends MinumanEvent {
  final int id;
  final File gambar;

  UploadGambarMinumanEvent(this.id, this.gambar);

  @override
  List<Object?> get props => [id, gambar];
}
