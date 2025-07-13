import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/kategori_barang_entity.dart';
import '../bloc/kategori_barang_bloc.dart';
import '../bloc/kategori_barang_event.dart';
import '../pages/form_kategori_barang_page.dart';

class KategoriBarangCard extends StatelessWidget {
  final KategoriBarangEntity entity;
  final int index;

  const KategoriBarangCard({
    Key? key,
    required this.entity,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> cardColors = [
      Colors.lightBlue.shade50,
      Colors.lightGreen.shade50,
      Colors.orange.shade50,
      Colors.purple.shade50,
      Colors.pink.shade50,
    ];

    return Card(
      color: cardColors[index % cardColors.length],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.category, color: Colors.blue),
        title: Text(entity.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(entity.deskripsi ?? '-'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FormKategoriBarangPage(
                      entity: entity,
                      isUpdate: true,
                    ),
                  ),
                );
                context.read<KategoriBarangBloc>().add(GetAllKategoriBarangEvent());
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<KategoriBarangBloc>().add(DeleteKategoriBarangEvent(entity.id));
                context.read<KategoriBarangBloc>().add(GetAllKategoriBarangEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
