import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/minuman_bloc.dart';
import '../bloc/minuman_event.dart';
import '../bloc/minuman_state.dart';
import '../../domain/entities/minuman_entity.dart';

class MinumanListPage extends StatefulWidget {
  const MinumanListPage({super.key});

  @override
  State<MinumanListPage> createState() => _MinumanListPageState();
}

class _MinumanListPageState extends State<MinumanListPage> {
  @override
  void initState() {
    super.initState();
    context.read<MinumanBloc>().add(GetAllMinumanEvent());
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
            if (state.listMinuman.isEmpty) {
              return const Center(child: Text('No Data'));
            }
            return ListView.builder(
              itemCount: state.listMinuman.length,
              itemBuilder: (context, index) {
                final item = state.listMinuman[index];
                return ListTile(
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
                            arguments: item,
                          );
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
          } else if (state is MinumanFailure) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No Data'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/minuman-form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
