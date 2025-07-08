import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/kategori_barang_entity.dart';
import '../bloc/kategori_barang_bloc.dart';
import '../bloc/kategori_barang_event.dart';
import '../bloc/kategori_barang_state.dart';

class KategoriBarangPage extends StatefulWidget {
  const KategoriBarangPage({Key? key}) : super(key: key);

  @override
  State<KategoriBarangPage> createState() => _KategoriBarangPageState();
}

class _KategoriBarangPageState extends State<KategoriBarangPage> {
  final _namaController = TextEditingController();
  final _deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<KategoriBarangBloc>().add(GetAllKategoriBarangEvent());
  }

  void _showForm({KategoriBarangEntity? kategori}) {
    if (kategori != null) {
      _namaController.text = kategori.nama;
      _deskripsiController.text = kategori.deskripsi ?? '';
    } else {
      _namaController.clear();
      _deskripsiController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(kategori == null ? 'Tambah Kategori' : 'Edit Kategori'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _deskripsiController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (kategori == null) {
                // Buat entity baru
                final entity = KategoriBarangEntity(
                  id: 0,
                  nama: _namaController.text,
                  deskripsi: _deskripsiController.text,
                );
                context.read<KategoriBarangBloc>().add(
                      CreateKategoriBarangEvent(entity),
                    );
              } else {
                // Update entity
                final entity = KategoriBarangEntity(
                  id: kategori.id,
                  nama: _namaController.text,
                  deskripsi: _deskripsiController.text,
                );
                context.read<KategoriBarangBloc>().add(
                      UpdateKategoriBarangEvent(kategori.id, entity),
                    );
              }
              Navigator.pop(context);
              // Refresh data
              context.read<KategoriBarangBloc>().add(GetAllKategoriBarangEvent());
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kategori Barang')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<KategoriBarangBloc, KategoriBarangState>(
        builder: (context, state) {
          if (state is KategoriBarangLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is KategoriBarangLoaded) {
            final kategoriList = state.list;

            if (kategoriList.isEmpty) {
              return const Center(child: Text('Belum ada kategori'));
            }

            return ListView.builder(
              itemCount: kategoriList.length,
              itemBuilder: (_, index) {
                final kategori = kategoriList[index];
                return ListTile(
                  title: Text(kategori.nama),
                  subtitle: Text(kategori.deskripsi ?? '-'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showForm(kategori: kategori),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<KategoriBarangBloc>().add(
                                DeleteKategoriBarangEvent(kategori.id),
                              );
                          // Refresh data
                          context.read<KategoriBarangBloc>().add(GetAllKategoriBarangEvent());
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is KategoriBarangError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
