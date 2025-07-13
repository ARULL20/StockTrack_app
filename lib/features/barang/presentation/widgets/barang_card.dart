import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/barang.dart';
import '../bloc/barang_bloc.dart';
import '../bloc/barang_event.dart';
import '../pages/form_barang_page.dart';

class BarangCard extends StatelessWidget {
  final Barang barang;

  const BarangCard({Key? key, required this.barang}) : super(key: key);

  void _openForm(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormBarangPage(barang: barang),
      ),
    );
    context.read<BarangBloc>().add(FetchBarang());
  }

  void _deleteBarang(BuildContext context) {
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
              context.read<BarangBloc>().add(DeleteBarangEvent(barang.id));
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (barang.gambar == null) {
      return const Icon(Icons.inventory, size: 60, color: Colors.grey);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        barang.gambar!,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.broken_image, size: 60, color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo.shade50,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: _buildImage(),
        title: Text(
          barang.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Stok: ${barang.stok}\nHarga: Rp${barang.harga.toStringAsFixed(0)}\nKategori: ${barang.kategoriBarangId} | Gudang: ${barang.gudangId}',
        ),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: () => _openForm(context),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteBarang(context),
            ),
          ],
        ),
      ),
    );
  }
}
