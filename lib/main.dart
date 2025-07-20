import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/table_resto_bloc.dart';
import 'bloc/table_resto_event.dart';
import 'repo/table_resto_repository.dart';
import 'ui/pages/table_index_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          TableRestoBloc(TableRestoRepository())..add(LoadTableRestoEvent()),
        ),
      ],
      child: const MaterialApp(
        title: 'Tabel Meja Restoran',
        debugShowCheckedModeBanner: false,
        home: TableIndexPage(),
      ),
    );
  }
}
