import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/table_resto_model.dart';
import '../repo/table_resto_repository.dart';
import '../param/table_resto_param.dart';
import 'table_resto_event.dart';
import 'table_resto_state.dart';

class TableRestoBloc extends Bloc<TableRestoEvent, TableRestoState> {
  final TableRestoRepository repository;

  TableRestoBloc(this.repository) : super(TableRestoInitial()) {
    on<LoadTableRestoEvent>(_onLoad);
    on<AddTableRestoEvent>(_onAdd);
    on<UpdateTableRestoEvent>(_onUpdate);
    on<DeleteTableRestoEvent>(_onDelete);
    on<SearchTableRestoEvent>(_onSearch);
  }

  Future<void> _onLoad(LoadTableRestoEvent event, Emitter<TableRestoState> emit) async {
    emit(TableRestoLoading());
    try {
      final data = await repository.fetchAll();
      emit(TableRestoLoaded(data));
    } catch (e) {
      emit(TableRestoError("Gagal memuat data"));
    }
  }

  Future<void> _onAdd(AddTableRestoEvent event, Emitter<TableRestoState> emit) async {
    try {
      await repository.addTable(event.param);
      add(LoadTableRestoEvent());
    } catch (e) {
      emit(TableRestoError("Gagal menambah data"));
    }
  }

  Future<void> _onUpdate(UpdateTableRestoEvent event, Emitter<TableRestoState> emit) async {
    try {
      await repository.updateTable(event.index, event.param);
      add(LoadTableRestoEvent());
    } catch (e) {
      emit(TableRestoError("Gagal memperbarui data"));
    }
  }

  Future<void> _onDelete(DeleteTableRestoEvent event, Emitter<TableRestoState> emit) async {
    try {
      await repository.deleteTable(event.index);
      add(LoadTableRestoEvent());
    } catch (e) {
      emit(TableRestoError("Gagal menghapus data"));
    }
  }

  Future<void> _onSearch(SearchTableRestoEvent event, Emitter<TableRestoState> emit) async {
    emit(TableRestoLoading());
    try {
      final data = await repository.search(event.keyword);
      emit(TableRestoLoaded(data));
    } catch (e) {
      emit(TableRestoError("Gagal mencari data"));
    }
  }
}
