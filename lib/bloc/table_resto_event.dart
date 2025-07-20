import 'package:equatable/equatable.dart';
import '../param/table_resto_param.dart';

abstract class TableRestoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTableRestoEvent extends TableRestoEvent {}

class AddTableRestoEvent extends TableRestoEvent {
  final TableRestoParam param;
  AddTableRestoEvent(this.param);

  @override
  List<Object?> get props => [param];
}

class UpdateTableRestoEvent extends TableRestoEvent {
  final int index;
  final TableRestoParam param;
  UpdateTableRestoEvent(this.index, this.param);

  @override
  List<Object?> get props => [index, param];
}

class DeleteTableRestoEvent extends TableRestoEvent {
  final int index;
  DeleteTableRestoEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class SearchTableRestoEvent extends TableRestoEvent {
  final String keyword;
  SearchTableRestoEvent(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
