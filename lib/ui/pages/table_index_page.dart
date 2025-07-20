import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/table_resto_bloc.dart';
import '../../bloc/table_resto_event.dart';
import '../../bloc/table_resto_state.dart';
import '../../models/table_resto_model.dart';
import '../../param/table_resto_param.dart';

class TableIndexPage extends StatefulWidget {
  const TableIndexPage({super.key});

  @override
  State<TableIndexPage> createState() => _TableIndexPageState();
}

class _TableIndexPageState extends State<TableIndexPage> {
  final TextEditingController _searchController = TextEditingController();

  void _showFormDialog({TableRestoModel? table, int? index}) {
    final kodeController = TextEditingController(text: table?.kode ?? '');
    final namaController = TextEditingController(text: table?.nama ?? '');
    final kapasitasController =
    TextEditingController(text: table?.kapasitas.toString() ?? '');

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(table == null ? 'Tambah Meja' : 'Edit Meja'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: kodeController,
                  decoration: InputDecoration(labelText: 'Kode'),
                ),
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(labelText: 'Nama'),
                ),
                TextField(
                  controller: kapasitasController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Kapasitas'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final param = TableRestoParam(
                  kode: kodeController.text,
                  nama: namaController.text,
                  kapasitas: int.tryParse(kapasitasController.text) ?? 0,
                );

                if (table == null) {
                  context.read<TableRestoBloc>().add(AddTableRestoEvent(param));
                } else if (index != null) {
                  context.read<TableRestoBloc>().add(UpdateTableRestoEvent(index, param));
                }

                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabel Meja Restoran'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari...',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    context.read<TableRestoBloc>().add(
                      SearchTableRestoEvent(_searchController.text),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TableRestoBloc, TableRestoState>(
              builder: (context, state) {
                if (state is TableRestoLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is TableRestoLoaded) {
                  final data = state.data;

                  if (data.isEmpty) {
                    return const Center(child: Text('Tidak ada data.'));
                  }

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final table = data[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          title: Text('${table.nama} (${table.kode})'),
                          subtitle: Text('Kapasitas: ${table.kapasitas}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.orange),
                                onPressed: () => _showFormDialog(table: table, index: index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  context.read<TableRestoBloc>().add(DeleteTableRestoEvent(index));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is TableRestoError) {
                  return Center(child: Text(state.message));
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
