import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/kategori_minuman_bloc.dart';
import '../bloc/kategori_minuman_event.dart';
import '../bloc/kategori_minuman_state.dart';
import 'form_kategori_minuman_page.dart';

class KategoriMinumanPage extends StatefulWidget {
  const KategoriMinumanPage({super.key});

  @override
  State<KategoriMinumanPage> createState() => _KategoriMinumanPageState();
}

class _KategoriMinumanPageState extends State<KategoriMinumanPage> {
  @override
  void initState() {
    super.initState();
    context.read<KategoriMinumanBloc>().add(GetAllKategoriMinumanEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Minuman'),
      ),
      body: BlocBuilder<KategoriMinumanBloc, KategoriMinumanState>(
        builder: (context, state) {
          if (state is KategoriMinumanLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is KategoriMinumanLoaded) {
            final list = state.kategoriMinumanList;


            if (list.isEmpty) {
              return const Center(child: Text('Belum ada kategori minuman'));
            }

            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return ListTile(
                  title: Text(item.nama),
                  subtitle: Text(item.deskripsi ?? '-'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FormKategoriMinumanPage(
                                isEdit: true,
                                kategori: item,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<KategoriMinumanBloc>().add(
                                DeleteKategoriMinumanEvent(item.id),
                              );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is KategoriMinumanError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FormKategoriMinumanPage(isEdit: false),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
