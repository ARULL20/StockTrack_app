// lib/features/barang/presentation/bloc/barang_event.dart

import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class BarangEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchBarang extends BarangEvent {}

class CreateBarangEvent extends BarangEvent {
  final Map<String, dynamic> data;
  final File? gambar;

  CreateBarangEvent(this.data, {this.gambar});

  @override
  List<Object?> get props => [data, gambar];
}


class UpdateBarangEvent extends BarangEvent {
  final int id;
  final Map<String, dynamic> data;
  UpdateBarangEvent(this.id, this.data);

  @override
  List<Object?> get props => [id, data];
}

class DeleteBarangEvent extends BarangEvent {
  final int id;
  DeleteBarangEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UploadGambarEvent extends BarangEvent {
  final int id;
  final File gambar;
  UploadGambarEvent(this.id, this.gambar);

  @override
  List<Object?> get props => [id, gambar];
}