import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/kategori_makanan.dart';
import '../bloc/kategori_makanan_bloc.dart';
import '../bloc/kategori_makanan_event.dart';

class FormKategoriMakananPage extends StatefulWidget {
  final KategoriMakanan? kategori;

  const FormKategoriMakananPage({super.key, this.kategori});

  @override
  State<FormKategoriMakananPage> createState() => _FormKategoriMakananPageState();
}

class _FormKategoriMakananPageState extends State<FormKategoriMakananPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _deskripsiController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.kategori?.nama ?? '');
    _deskripsiController = TextEditingController(text: widget.kategori?.deskripsi ?? '');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'nama': _namaController.text,
        'deskripsi': _deskripsiController.text,
      };

      if (widget.kategori == null) {
        context.read<KategoriMakananBloc>().add(CreateKategoriMakananEvent(data));
      } else {
        context.read<KategoriMakananBloc>().add(UpdateKategoriMakananEvent(widget.kategori!.id, data));
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kategori == null ? 'Tambah Kategori Makanan' : 'Edit Kategori Makanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) => value == null || value.isEmpty ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
