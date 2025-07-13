import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/kategori_barang_bloc.dart';
import '../bloc/kategori_barang_event.dart';
import '../widgets/kategori_barang_list.dart';
import 'form_kategori_barang_page.dart';

class KategoriBarangPage extends StatefulWidget {
  const KategoriBarangPage({Key? key}) : super(key: key);

  @override
  State<KategoriBarangPage> createState() => _KategoriBarangPageState();
}

class _KategoriBarangPageState extends State<KategoriBarangPage> {
  @override
  void initState() {
    super.initState();
    context.read<KategoriBarangBloc>().add(GetAllKategoriBarangEvent());
  }

  void _navigateToForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FormKategoriBarangPage()),
    ).then((_) {
      context.read<KategoriBarangBloc>().add(GetAllKategoriBarangEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kategori Barang')),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToForm,
        child: const Icon(Icons.add),
      ),
      body: const KategoriBarangList(),
    );
  }
}
