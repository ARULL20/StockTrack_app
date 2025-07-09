import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/barang_keluar_bloc.dart';
import '../bloc/barang_keluar_event.dart';
import '../bloc/barang_keluar_state.dart';
import 'form_barang_keluar_page.dart';

class BarangKeluarPage extends StatefulWidget {
  const BarangKeluarPage({super.key});

  @override
  State<BarangKeluarPage> createState() => _BarangKeluarPageState();
}

class _BarangKeluarPageState extends State<BarangKeluarPage> {
  @override
  void initState() {
    super.initState();
    context.read<BarangKeluarBloc>().add(GetAllBarangKeluarEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barang Keluar')),
      body: BlocConsumer<BarangKeluarBloc, BarangKeluarState>(
        listener: (context, state) {
          if (state is BarangKeluarSuccess) {
            context.read<BarangKeluarBloc>().add(GetAllBarangKeluarEvent());
          } else if (state is BarangKeluarError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is BarangKeluarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BarangKeluarLoaded) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final barangKeluar = state.list[index];
                return ListTile(
                  title: Text(barangKeluar.barang.nama),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jumlah: ${barangKeluar.jumlah}'),
                      Text('Harga: ${barangKeluar.harga}'),
                      if (barangKeluar.keterangan != null)
                        Text('Keterangan: ${barangKeluar.keterangan}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FormBarangKeluarPage(
                                barangKeluar: barangKeluar,
                              ),
                            ),
                          );
                          if (result == true) {
                            context
                                .read<BarangKeluarBloc>()
                                .add(GetAllBarangKeluarEvent());
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<BarangKeluarBloc>()
                              .add(DeleteBarangKeluarEvent(barangKeluar.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is BarangKeluarError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Tidak ada data.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FormBarangKeluarPage(),
            ),
          );

          if (result == true) {
            context.read<BarangKeluarBloc>().add(GetAllBarangKeluarEvent());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
