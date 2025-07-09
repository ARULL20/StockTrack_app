import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/minuman_entity.dart';
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

  MinumanEntity? _editingMinuman;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is MinumanEntity) {
      _editingMinuman = args;
      _namaController.text = args.nama;
      _deskripsiController.text = args.deskripsi ?? '';
      _hargaController.text = args.harga.toString();
      _kategoriController.text = args.kategoriMinumanId.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Minuman')),
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
                  final minuman = MinumanEntity(
                    id: _editingMinuman?.id ?? 0,
                    nama: _namaController.text,
                    deskripsi: _deskripsiController.text,
                    harga: double.tryParse(_hargaController.text) ?? 0,
                    kategoriMinumanId: int.tryParse(_kategoriController.text) ?? 0,
                  );

                  if (_editingMinuman == null) {
                    context.read<MinumanBloc>().add(CreateMinumanEvent(minuman));
                  } else {
                    context.read<MinumanBloc>().add(UpdateMinumanEvent(minuman));
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
