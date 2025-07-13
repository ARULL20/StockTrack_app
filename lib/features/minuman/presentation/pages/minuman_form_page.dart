import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/minuman_bloc.dart';
import '../bloc/minuman_event.dart';

class MinumanFormPage extends StatefulWidget {
  const MinumanFormPage({super.key});

  @override
  State<MinumanFormPage> createState() => _MinumanFormPageState();
}

class _MinumanFormPageState extends State<MinumanFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _hargaController = TextEditingController();
  final _kategoriController = TextEditingController();

  File? _gambar;
  Map<String, dynamic>? minumanEdit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Map<String, dynamic>) {
      minumanEdit = args;
      _namaController.text = minumanEdit!['nama'] ?? '';
      _deskripsiController.text = minumanEdit!['deskripsi'] ?? '';
      _hargaController.text = minumanEdit!['harga'].toString();
      _kategoriController.text = minumanEdit!['kategori_minuman_id'].toString();
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
    } else if (minumanEdit != null && minumanEdit!['gambar'] != null) {
      final url = 'http://10.0.2.2:8000/storage/${minumanEdit!['gambar']}';
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
        title: Text(minumanEdit == null ? 'Tambah Minuman' : 'Edit Minuman'),
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
                      'kategori_minuman_id': int.tryParse(_kategoriController.text) ?? 0,
                    };

                    if (minumanEdit == null) {
                      context.read<MinumanBloc>().add(
                            CreateMinumanEvent(data, gambar: _gambar),
                          );
                    } else {
                      final id = minumanEdit!['id'];
                      context.read<MinumanBloc>().add(
                            UpdateMinumanEvent(id, data),
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
