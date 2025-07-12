import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/laporan_bloc.dart';
import '../bloc/laporan_event.dart';
import '../bloc/laporan_state.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  @override
  void initState() {
    super.initState();
    // Panggil bloc yang SUDAH ADA di MultiBlocProvider
    final laporanBloc = context.read<LaporanBloc>();
    laporanBloc.add(LoadPemasukan());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Laporan'),
      ),
      body: BlocBuilder<LaporanBloc, LaporanState>(
        builder: (context, state) {
          if (state is LaporanLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LaporanLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Pemasukan: Rp ${state.totalPemasukan.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Total Pengeluaran: Rp ${state.totalPengeluaran.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          } else if (state is LaporanError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
