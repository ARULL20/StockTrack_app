import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/kategori_makanan.dart';
import '../bloc/kategori_makanan_bloc.dart';
import '../bloc/kategori_makanan_event.dart';
import '../bloc/kategori_makanan_state.dart';
import 'form_kategori_makanan_page.dart';

class KategoriMakananPage extends StatefulWidget {
  const KategoriMakananPage({super.key});

  @override
  State<KategoriMakananPage> createState() => _KategoriMakananPageState();
}

class _KategoriMakananPageState extends State<KategoriMakananPage> {
  @override
  void initState() {
    super.initState();
    context.read<KategoriMakananBloc>().add(FetchKategoriMakanan());
  }

  void _openForm({KategoriMakanan? kategori}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormKategoriMakananPage(kategori: kategori),
      ),
    );
    context.read<KategoriMakananBloc>().add(FetchKategoriMakanan());
  }

  void _deleteKategori(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Kategori Makanan'),
        content: const Text('Yakin mau hapus kategori ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<KategoriMakananBloc>().add(DeleteKategoriMakananEvent(id));
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kategori Makanan')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<KategoriMakananBloc, KategoriMakananState>(
        builder: (context, state) {
          if (state is KategoriMakananLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is KategoriMakananLoaded) {
            final list = state.list;

            if (list.isEmpty) {
              return const Center(child: Text('Belum ada kategori.'));
            }

            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                final kategori = list[index];
                return ListTile(
                  leading: const Icon(Icons.fastfood),
                  title: Text(kategori.nama),
                  subtitle: Text(kategori.deskripsi ?? '-'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _openForm(kategori: kategori),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteKategori(kategori.id),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is KategoriMakananError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
