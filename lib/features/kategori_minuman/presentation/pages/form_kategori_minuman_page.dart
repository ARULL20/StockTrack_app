import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/kategori_minuman_bloc.dart';
import '../bloc/kategori_minuman_event.dart';
import '../../domain/entities/kategori_minuman.dart';

class FormKategoriMinumanPage extends StatefulWidget {
  final bool isEdit;
  final KategoriMinuman? kategori;

  const FormKategoriMinumanPage({
    super.key,
    required this.isEdit,
    this.kategori,
  });

  @override
  State<FormKategoriMinumanPage> createState() =>
      _FormKategoriMinumanPageState();
}

class _FormKategoriMinumanPageState extends State<FormKategoriMinumanPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.kategori != null) {
      _namaController.text = widget.kategori!.nama;
      _deskripsiController.text = widget.kategori!.deskripsi ?? '';
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'nama': _namaController.text.trim(),
        'deskripsi': _deskripsiController.text.trim(),
      };

      if (widget.isEdit) {
        context.read<KategoriMinumanBloc>().add(
              UpdateKategoriMinumanEvent(widget.kategori!.id, data),
            );
      } else {
        context.read<KategoriMinumanBloc>().add(
              CreateKategoriMinumanEvent(data),
            );
      }

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Edit Kategori Minuman' : 'Tambah Kategori Minuman',
        ),
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
