import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/barang.dart';
import '../bloc/barang_bloc.dart';
import '../bloc/barang_event.dart';
import '../bloc/barang_state.dart';
import 'form_barang_page.dart';

class BarangPage extends StatefulWidget {
  const BarangPage({Key? key}) : super(key: key);

  @override
  State<BarangPage> createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  @override
  void initState() {
    super.initState();
    context.read<BarangBloc>().add(FetchBarang());
  }

  void _openForm({Barang? barang}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormBarangPage(barang: barang),
      ),
    );
    context.read<BarangBloc>().add(FetchBarang());
  }

  void _deleteBarang(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Barang'),
        content: const Text('Apakah Anda yakin ingin menghapus barang ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<BarangBloc>().add(DeleteBarangEvent(id));
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

      Widget buildBarangImage(String? gambar) {
    print('🟢 [DEBUG] URL GAMBAR: $gambar');
    if (gambar == null) {
      return const Icon(Icons.inventory, size: 50);
    }
    return Image.network(
      gambar,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print('🔴 [ERROR IMAGE]: $error');
        return const Icon(Icons.broken_image, size: 50);
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Barang')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<BarangBloc, BarangState>(
        builder: (context, state) {
          if (state is BarangLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BarangLoaded) {
            final barangList = state.barangList;

            if (barangList.isEmpty) {
              return const Center(child: Text('Belum ada barang'));
            }

            return ListView.builder(
              itemCount: barangList.length,
              itemBuilder: (_, index) {
                final barang = barangList[index];
                return ListTile(
                  leading: buildBarangImage(barang.gambar),
                  title: Text(barang.nama),
                  subtitle: Text(
                    'Stok: ${barang.stok} - Harga: Rp${barang.harga.toStringAsFixed(0)}\nKategori: ${barang.kategoriBarangId}, Gudang: ${barang.gudangId}',
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _openForm(barang: barang),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteBarang(barang.id),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is BarangError) {
            return Center(child: Text(state.error));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}