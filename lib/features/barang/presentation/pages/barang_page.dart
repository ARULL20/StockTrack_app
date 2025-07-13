import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/barang_bloc.dart';
import '../bloc/barang_event.dart';
import '../widgets/barang_list.dart';
import 'form_barang_page.dart';

class BarangPage extends StatefulWidget {
  const BarangPage({Key? key}) : super(key: key);

  @override
  State<BarangPage> createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  @override
  void initState() {
    super.initState();
    context.read<BarangBloc>().add(FetchBarang());
  }

  void _openForm() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FormBarangPage()),
    );
    context.read<BarangBloc>().add(FetchBarang());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Barang')),
      floatingActionButton: FloatingActionButton(
        onPressed: _openForm,
        child: const Icon(Icons.add),
      ),
      body: const BarangList(),
    );
  }
}
