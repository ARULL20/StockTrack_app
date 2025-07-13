import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/makanan_bloc.dart';
import '../bloc/makanan_event.dart';
import '../bloc/makanan_state.dart';

class MakananListPage extends StatefulWidget {
  const MakananListPage({super.key});

  @override
  State<MakananListPage> createState() => _MakananListPageState();
}

class _MakananListPageState extends State<MakananListPage> {
  @override
  void initState() {
    super.initState();
    context.read<MakananBloc>().add(FetchMakanan());
  }

  Widget buildMakananImage(String? gambar) {
    if (gambar == null || gambar.isEmpty) {
      return const Icon(Icons.image_not_supported, size: 50);
    }
    final fullUrl = 'http://10.0.2.2:8000/storage/$gambar';
    print('DEBUG URL GAMBAR: $fullUrl');
    return Image.network(
      fullUrl,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.broken_image, size: 50);
      },
    );
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
            if (state.makananList.isEmpty) {
              return const Center(child: Text('Data Kosong'));
            }
            return ListView.builder(
              itemCount: state.makananList.length,
              itemBuilder: (context, index) {
                final item = state.makananList[index];
                return ListTile(
                  leading: buildMakananImage(item.gambar),
                  title: Text(item.nama),
                  subtitle: Text('Rp ${item.harga.toStringAsFixed(0)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/makanan-form',
                            arguments: {
                              'id': item.id,
                              'nama': item.nama,
                              'deskripsi': item.deskripsi,
                              'harga': item.harga,
                              'kategori_makanan_id': item.kategoriMakananId,
                              'gambar': item.gambar,
                            },
                          ).then((_) {
                            context.read<MakananBloc>().add(FetchMakanan());
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
          } else if (state is MakananError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/makanan-form').then((_) {
            context.read<MakananBloc>().add(FetchMakanan());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
