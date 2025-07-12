import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/barang.dart';
import '../bloc/barang_bloc.dart';
import '../bloc/barang_event.dart';

class FormBarangPage extends StatefulWidget {
  final Barang? barang;
  const FormBarangPage({Key? key, this.barang}) : super(key: key);

  @override
  State<FormBarangPage> createState() => _FormBarangPageState();
}

class _FormBarangPageState extends State<FormBarangPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _deskripsiController;
  late TextEditingController _stokController;
  late TextEditingController _hargaController;
  late TextEditingController _kategoriIdController;
  late TextEditingController _gudangIdController;

  XFile? _pickedImage;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.barang?.nama ?? '');
    _deskripsiController = TextEditingController(text: widget.barang?.deskripsi ?? '');
    _stokController = TextEditingController(text: widget.barang?.stok.toString() ?? '');
    _hargaController = TextEditingController(text: widget.barang?.harga.toString() ?? '');
    _kategoriIdController = TextEditingController(text: widget.barang?.kategoriBarangId.toString() ?? '');
    _gudangIdController = TextEditingController(text: widget.barang?.gudangId.toString() ?? '');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    _stokController.dispose();
    _hargaController.dispose();
    _kategoriIdController.dispose();
    _gudangIdController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = picked;
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
  final ImagePicker picker = ImagePicker();
  final picked = await picker.pickImage(source: ImageSource.camera);
  if (picked != null) {
    setState(() {
      _pickedImage = picked;
    });
  }
}


  void _save() async {
  if (_formKey.currentState!.validate()) {
    final data = {
      'nama': _namaController.text,
      'deskripsi': _deskripsiController.text,
      'stok': int.parse(_stokController.text),
      'harga': double.parse(_hargaController.text),
      'kategori_barang_id': int.parse(_kategoriIdController.text),
      'gudang_id': int.parse(_gudangIdController.text),
    };

    final bloc = context.read<BarangBloc>();

    if (widget.barang == null) {
      final id = await bloc.createBarang.call(data);
      if (_pickedImage != null) {
        await bloc.uploadGambarBarang.call(id, File(_pickedImage!.path));
      }
      bloc.add(FetchBarang());
    } else {
      bloc.add(UpdateBarangEvent(widget.barang!.id, data));
      if (_pickedImage != null) {
        bloc.add(UploadGambarEvent(widget.barang!.id, File(_pickedImage!.path)));
      }
    }

    Navigator.pop(context);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.barang == null ? 'Tambah Barang' : 'Edit Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
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
              TextFormField(
                controller: _stokController,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  if (int.tryParse(value) == null) return 'Harus angka';
                  return null;
                },
              ),
              TextFormField(
                controller: _hargaController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  if (double.tryParse(value) == null) return 'Harus angka';
                  return null;
                },
              ),
              TextFormField(
                controller: _kategoriIdController,
                decoration: const InputDecoration(labelText: 'Kategori Barang ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  if (int.tryParse(value) == null) return 'Harus angka';
                  return null;
                },
              ),
              TextFormField(
                controller: _gudangIdController,
                decoration: const InputDecoration(labelText: 'Gudang ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  if (int.tryParse(value) == null) return 'Harus angka';
                  return null;
                },
              ),
              const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _pickImageFromCamera, 
                  child: const Text('Ambil Foto'),
                ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pilih dari Galeri'),
                ),
              ],
            ),
            if (_pickedImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Image.file(
                  File(_pickedImage!.path),
                  height: 150,
                ),
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
