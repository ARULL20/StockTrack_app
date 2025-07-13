import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/makanan_bloc.dart';
import '../bloc/makanan_event.dart';

class MakananFormPage extends StatefulWidget {
  const MakananFormPage({super.key});

  @override
  State<MakananFormPage> createState() => _MakananFormPageState();
}

class _MakananFormPageState extends State<MakananFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _hargaController = TextEditingController();
  final _kategoriController = TextEditingController();

  File? _gambar;
  Map<String, dynamic>? makananEdit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Map<String, dynamic>) {
      makananEdit = args;
      _namaController.text = makananEdit!['nama'] ?? '';
      _deskripsiController.text = makananEdit!['deskripsi'] ?? '';
      _hargaController.text = makananEdit!['harga'].toString();
      _kategoriController.text = makananEdit!['kategori_makanan_id'].toString();
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _gambar = File(pickedFile.path);
      });
    }
  }

  Widget _buildImagePreview() {
    if (_gambar != null) {
      return Image.file(
        _gambar!,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      );
    } else if (makananEdit != null && makananEdit!['gambar'] != null) {
      final url = 'http://10.0.2.2:8000/storage/${makananEdit!['gambar']}';
      return Image.network(
        url,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 100);
        },
      );
    } else {
      return const Icon(Icons.image, size: 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(makananEdit == null ? 'Tambah Makanan' : 'Edit Makanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                TextFormField(
                  controller: _deskripsiController,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                ),
                TextFormField(
                  controller: _hargaController,
                  decoration: const InputDecoration(labelText: 'Harga'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _kategoriController,
                  decoration: const InputDecoration(labelText: 'Kategori ID'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                _buildImagePreview(),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.photo),
                  label: const Text('Pilih Gambar'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final data = {
                      'nama': _namaController.text,
                      'deskripsi': _deskripsiController.text,
                      'harga': double.tryParse(_hargaController.text) ?? 0,
                      'kategori_makanan_id': int.tryParse(_kategoriController.text) ?? 0,
                    };

                    if (makananEdit == null) {
                      // CREATE
                      context.read<MakananBloc>().add(
                            CreateMakananEvent(data, gambar: _gambar),
                          );
                    } else {
                      // UPDATE
                      final id = makananEdit!['id'];
                      context.read<MakananBloc>().add(
                            UpdateMakananEvent(id, data),
                          );
                    }

                    Navigator.pop(context);
                  },
                  child: const Text('Simpan'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
