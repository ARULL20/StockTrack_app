import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/kategori_barang_entity.dart';
import '../bloc/kategori_barang_bloc.dart';
import '../bloc/kategori_barang_event.dart';
import '../bloc/kategori_barang_state.dart';
import 'kategori_barang_card.dart';
import '../pages/form_kategori_barang_page.dart';

class KategoriBarangList extends StatelessWidget {
  const KategoriBarangList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KategoriBarangBloc, KategoriBarangState>(
      builder: (context, state) {
        if (state is KategoriBarangLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is KategoriBarangLoaded) {
          final kategoriList = state.list;

          if (kategoriList.isEmpty) {
            return const Center(child: Text('Belum ada kategori'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: kategoriList.length,
            itemBuilder: (_, index) {
              final kategori = kategoriList[index];
              return KategoriBarangCard(
                entity: kategori,
                index: index,
              );
            },
          );
        } else if (state is KategoriBarangError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
