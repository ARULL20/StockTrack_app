import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/gudang_bloc.dart';
import '../bloc/gudang_event.dart';
import '../bloc/gudang_state.dart';
import '../../domain/entities/gudang_entity.dart';
import 'form_gudang_page.dart';

class GudangPage extends StatefulWidget {
  const GudangPage({super.key});

  @override
  State<GudangPage> createState() => _GudangPageState();
}

class _GudangPageState extends State<GudangPage> {
  @override
  void initState() {
    super.initState();
    context.read<GudangBloc>().add(GetAllGudangEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gudang')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormGudangPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<GudangBloc, GudangState>(
        listener: (context, state) {
          if (state is GudangSuccess) {
            // Kalau CRUD berhasil, reload lagi
            context.read<GudangBloc>().add(GetAllGudangEvent());
          }
        },
        builder: (context, state) {
          if (state is GudangLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GudangLoaded) {
            final list = state.list;

            if (list.isEmpty) {
              return const Center(child: Text('Belum ada data gudang.'));
            }

            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final gudang = list[index];
                return ListTile(
                  title: Text(gudang.nama),
                  subtitle: Text(gudang.lokasi ?? '-'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FormGudangPage(entity: gudang, isUpdate: true),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<GudangBloc>().add(DeleteGudangEvent(gudang.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is GudangError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
