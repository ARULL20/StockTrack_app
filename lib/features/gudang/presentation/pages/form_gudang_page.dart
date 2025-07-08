import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/gudang_bloc.dart';
import '../bloc/gudang_event.dart';
import '../../domain/entities/gudang_entity.dart';

class FormGudangPage extends StatefulWidget {
  final GudangEntity? entity;
  final bool isUpdate;

  const FormGudangPage({super.key, this.entity, this.isUpdate = false});

  @override
  State<FormGudangPage> createState() => _FormGudangPageState();
}

class _FormGudangPageState extends State<FormGudangPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _lokasiController;
  late TextEditingController _deskripsiController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.entity?.nama ?? '');
    _lokasiController = TextEditingController(text: widget.entity?.lokasi ?? '');
    _deskripsiController = TextEditingController(text: widget.entity?.deskripsi ?? '');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _lokasiController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final entity = GudangEntity(
        id: widget.entity?.id ?? 0,
        nama: _namaController.text,
        lokasi: _lokasiController.text,
        deskripsi: _deskripsiController.text,
      );

      if (widget.isUpdate) {
        context.read<GudangBloc>().add(UpdateGudangEvent(widget.entity!.id, entity));
      } else {
        context.read<GudangBloc>().add(CreateGudangEvent(entity));
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdate ? 'Edit Gudang' : 'Tambah Gudang'),
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
                controller: _lokasiController,
                decoration: const InputDecoration(labelText: 'Lokasi'),
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
