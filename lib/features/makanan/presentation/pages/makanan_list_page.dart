import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/makanan_bloc.dart';
import '../bloc/makanan_event.dart';
import '../bloc/makanan_state.dart';

import '../../domain/entities/makanan_entity.dart';

class MakananListPage extends StatefulWidget {
  const MakananListPage({super.key});

  @override
  State<MakananListPage> createState() => _MakananListPageState();
}

class _MakananListPageState extends State<MakananListPage> {
  @override
  void initState() {
    super.initState();
    // ✅ Trigger GET saat pertama buka
    context.read<MakananBloc>().add(GetAllMakananEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Makanan')),
      body: BlocBuilder<MakananBloc, MakananState>(
        builder: (context, state) {
          if (state is MakananLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MakananLoaded) {
            if (state.listMakanan.isEmpty) {
              return const Center(child: Text('Data Kosong'));
            }
            return ListView.builder(
              itemCount: state.listMakanan.length,
              itemBuilder: (context, index) {
                final item = state.listMakanan[index];
                return ListTile(
                  title: Text(item.nama),
                  subtitle: Text('Rp ${item.harga.toStringAsFixed(0)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // ✅ Buka form dengan ARG edit
                          Navigator.pushNamed(
                            context,
                            '/makanan-form',
                            arguments: item,
                          ).then((_) {
                            // ⏬ Refresh saat kembali dari form
                            context.read<MakananBloc>().add(GetAllMakananEvent());
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<MakananBloc>().add(DeleteMakananEvent(item.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is MakananFailure) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/makanan-form').then((_) {
            // ⏬ Refresh saat kembali dari form tambah
            context.read<MakananBloc>().add(GetAllMakananEvent());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
