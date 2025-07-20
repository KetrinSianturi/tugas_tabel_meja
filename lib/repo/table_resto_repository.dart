import '../models/table_resto_model.dart';
import '../param/table_resto_param.dart';

class TableRestoRepository {
  final List<TableRestoModel> _data = [];

  Future<List<TableRestoModel>> fetchAll() async {
    await Future.delayed(Duration(milliseconds: 300));
    return _data;
  }

  Future<void> addTable(TableRestoParam param) async {
    _data.add(TableRestoModel(
      kode: param.kode,
      nama: param.nama,
      kapasitas: param.kapasitas,
    ));
  }

  Future<void> updateTable(int index, TableRestoParam param) async {
    _data[index] = TableRestoModel(
      kode: param.kode,
      nama: param.nama,
      kapasitas: param.kapasitas,
    );
  }

  Future<void> deleteTable(int index) async {
    _data.removeAt(index);
  }

  Future<List<TableRestoModel>> search(String keyword) async {
    return _data
        .where((e) =>
    e.kode.toLowerCase().contains(keyword.toLowerCase()) ||
        e.nama.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }
}
