import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/kategori_barang_bloc.dart';
import '../bloc/kategori_barang_event.dart';
import '../../domain/entities/kategori_barang_entity.dart';

class FormKategoriBarangPage extends StatefulWidget {
  const FormKategoriBarangPage({super.key, this.entity, this.isUpdate = false});

  final KategoriBarangEntity? entity;
  final bool isUpdate;

  @override
  State<FormKategoriBarangPage> createState() => _FormKategoriBarangPageState();
}

class _FormKategoriBarangPageState extends State<FormKategoriBarangPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _deskripsiController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.entity?.nama ?? '');
    _deskripsiController = TextEditingController(text: widget.entity?.deskripsi ?? '');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final entity = KategoriBarangEntity(
        id: widget.entity?.id ?? 0,
        nama: _namaController.text,
        deskripsi: _deskripsiController.text,
      );

      if (widget.isUpdate && widget.entity != null) {
        context.read<KategoriBarangBloc>().add(UpdateKategoriBarangEvent(widget.entity!.id, entity));
      } else {
        context.read<KategoriBarangBloc>().add(CreateKategoriBarangEvent(entity));
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdate ? 'Edit Kategori' : 'Tambah Kategori'),
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
                validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
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
