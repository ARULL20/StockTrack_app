import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/barang.dart';
import '../bloc/barang_bloc.dart';
import '../bloc/barang_event.dart';
import '../bloc/barang_state.dart';
import '../widgets/barang_card.dart';

class BarangList extends StatelessWidget {
  const BarangList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarangBloc, BarangState>(
      builder: (context, state) {
        if (state is BarangLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BarangLoaded) {
          final barangList = state.barangList;

          if (barangList.isEmpty) {
            return const Center(child: Text('Belum ada barang'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: barangList.length,
            itemBuilder: (_, index) {
              return BarangCard(barang: barangList[index]);
            },
          );
        } else if (state is BarangError) {
          return Center(child: Text(state.error));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
