import 'package:equatable/equatable.dart';
import '../../domain/entities/kategori_minuman.dart';

abstract class KategoriMinumanState extends Equatable {
  const KategoriMinumanState();

  @override
  List<Object?> get props => [];
}

class KategoriMinumanInitial extends KategoriMinumanState {}

class KategoriMinumanLoading extends KategoriMinumanState {}

class KategoriMinumanLoaded extends KategoriMinumanState {
  final List<KategoriMinuman> kategoriMinumanList;

  const KategoriMinumanLoaded(this.kategoriMinumanList);

  @override
  List<Object?> get props => [kategoriMinumanList];
}

class KategoriMinumanSuccess extends KategoriMinumanState {}

class KategoriMinumanError extends KategoriMinumanState {
  final String message;

  const KategoriMinumanError(this.message);

  @override
  List<Object?> get props => [message];
}
