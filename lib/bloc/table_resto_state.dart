import 'package:equatable/equatable.dart';
import '../models/table_resto_model.dart';

abstract class TableRestoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TableRestoInitial extends TableRestoState {}

class TableRestoLoading extends TableRestoState {}

class TableRestoLoaded extends TableRestoState {
  final List<TableRestoModel> data;

  TableRestoLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class TableRestoError extends TableRestoState {
  final String message;

  TableRestoError(this.message);

  @override
  List<Object?> get props => [message];
}
