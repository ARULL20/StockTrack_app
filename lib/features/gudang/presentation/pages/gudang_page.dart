import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
            context.read<GudangBloc>().add(GetAllGudangEvent());
          } else if (state is GudangError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
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
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(gudang.nama),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(gudang.lokasi ?? '-'),
                              if (gudang.latitude != null && gudang.longitude != null)
                                Text('📍 ${gudang.latitude}, ${gudang.longitude}'),
                            ],
                          ),
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
                        ),
                        if (gudang.latitude != null && gudang.longitude != null)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            height: 200,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(gudang.latitude!, gudang.longitude!),
                                zoom: 15,
                              ),
                              markers: {
                                Marker(
                                  markerId: MarkerId(gudang.id.toString()),
                                  position: LatLng(gudang.latitude!, gudang.longitude!),
                                ),
                              },
                              zoomControlsEnabled: false,
                              liteModeEnabled: true, // Supaya ringan
                            ),
                          ),
                      ],
                    ),
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
