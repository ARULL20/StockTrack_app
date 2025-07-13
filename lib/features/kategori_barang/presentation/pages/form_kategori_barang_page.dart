import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stoktrack_app/core/widgets/custom_textfield.dart';

import '../../domain/entities/kategori_barang_entity.dart';
import '../bloc/kategori_barang_bloc.dart';
import '../bloc/kategori_barang_event.dart';

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
              CustomTextField(
                controller: _namaController,
                label: 'Nama',
                isRequired: true,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _deskripsiController,
                label: 'Deskripsi',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
