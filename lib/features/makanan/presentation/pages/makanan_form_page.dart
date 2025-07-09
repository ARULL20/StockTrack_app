import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/makanan_entity.dart';
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

  MakananEntity? makananEdit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is MakananEntity) {
      makananEdit = args;
      _namaController.text = makananEdit!.nama;
      _deskripsiController.text = makananEdit!.deskripsi;
      _hargaController.text = makananEdit!.harga.toString();
      _kategoriController.text = makananEdit!.kategoriMakananId.toString();
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
              ElevatedButton(
                onPressed: () {
                  final makanan = MakananEntity(
                    id: makananEdit?.id ?? 0,
                    nama: _namaController.text,
                    deskripsi: _deskripsiController.text,
                    harga: double.tryParse(_hargaController.text) ?? 0,
                    kategoriMakananId: int.tryParse(_kategoriController.text) ?? 0,
                  );

                  if (makananEdit == null) {
                    context.read<MakananBloc>().add(CreateMakananEvent(makanan));
                  } else {
                    context.read<MakananBloc>().add(UpdateMakananEvent(makanan));
                  }

                  Navigator.pop(context);
                },
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
