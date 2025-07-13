import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/minuman_bloc.dart';
import '../bloc/minuman_event.dart';
import '../bloc/minuman_state.dart';

class MinumanListPage extends StatefulWidget {
  const MinumanListPage({super.key});

  @override
  State<MinumanListPage> createState() => _MinumanListPageState();
}

class _MinumanListPageState extends State<MinumanListPage> {
  @override
  void initState() {
    super.initState();
    context.read<MinumanBloc>().add(FetchMinuman());
  }

  Widget buildMinumanImage(String? gambar) {
    if (gambar == null || gambar.isEmpty) {
      return const Icon(Icons.image_not_supported, size: 50);
    }
    final fullUrl = 'http://10.0.2.2:8000/storage/$gambar';
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
      appBar: AppBar(title: const Text('List Minuman')),
      body: BlocBuilder<MinumanBloc, MinumanState>(
        builder: (context, state) {
          if (state is MinumanLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MinumanLoaded) {
            if (state.minumanList.isEmpty) {
              return const Center(child: Text('Data Kosong'));
            }
            return ListView.builder(
              itemCount: state.minumanList.length,
              itemBuilder: (context, index) {
                final item = state.minumanList[index];
                return ListTile(
                  leading: buildMinumanImage(item.gambar),
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
                            '/minuman-form',
                            arguments: {
                              'id': item.id,
                              'nama': item.nama,
                              'deskripsi': item.deskripsi,
                              'harga': item.harga,
                              'kategori_minuman_id': item.kategoriMinumanId,
                              'gambar': item.gambar,
                            },
                          ).then((_) {
                            context.read<MinumanBloc>().add(FetchMinuman());
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<MinumanBloc>().add(DeleteMinumanEvent(item.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is MinumanError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/minuman-form').then((_) {
            context.read<MinumanBloc>().add(FetchMinuman());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
