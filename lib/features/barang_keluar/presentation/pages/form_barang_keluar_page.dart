import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stoktrack_app/features/barang/domain/entities/barang.dart';
import 'package:stoktrack_app/features/barang/presentation/bloc/barang_bloc.dart';
import 'package:stoktrack_app/features/barang/presentation/bloc/barang_event.dart';
import 'package:stoktrack_app/features/barang/presentation/bloc/barang_state.dart';
import '../bloc/barang_keluar_bloc.dart';
import '../bloc/barang_keluar_event.dart';
import '../bloc/barang_keluar_state.dart';
import '../../domain/entities/barang_keluar.dart';

class FormBarangKeluarPage extends StatefulWidget {
  final BarangKeluar? barangKeluar;

  const FormBarangKeluarPage({super.key, this.barangKeluar});

  @override
  State<FormBarangKeluarPage> createState() => _FormBarangKeluarPageState();
}

class _FormBarangKeluarPageState extends State<FormBarangKeluarPage> {
  final _formKey = GlobalKey<FormState>();
  int? _barangId;
  int? _jumlah;
  double? _harga;
  String? _keterangan;

  @override
  void initState() {
    super.initState();
    context.read<BarangBloc>().add(FetchBarang()); // trigger ambil data barang

    // jika edit
    if (widget.barangKeluar != null) {
      final data = widget.barangKeluar!;
      _barangId = data.barangId;
      _jumlah = data.jumlah;
      _harga = data.harga;
      _keterangan = data.keterangan;
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final data = {
        "barang_id": _barangId,
        "jumlah": _jumlah,
        "harga": _harga,
        "keterangan": _keterangan,
      };

      if (widget.barangKeluar == null) {
        context.read<BarangKeluarBloc>().add(CreateBarangKeluarEvent(data));
      } else {
        context
            .read<BarangKeluarBloc>()
            .add(UpdateBarangKeluarEvent(widget.barangKeluar!.id, data));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.barangKeluar == null ? 'Tambah Barang Keluar' : 'Edit Barang Keluar')),
      body: BlocConsumer<BarangKeluarBloc, BarangKeluarState>(
        listener: (context, state) {
          if (state is BarangKeluarSuccess) {
            Navigator.pop(context, true);
          } else if (state is BarangKeluarError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal menyimpan: ${state.message}')),
            );
          }
        },
        builder: (context, stateKeluar) {
          return BlocBuilder<BarangBloc, BarangState>(
            builder: (context, stateBarang) {
              if (stateBarang is BarangLoading || stateKeluar is BarangKeluarLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (stateBarang is BarangLoaded) {
                final listBarang = stateBarang.barangList;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        DropdownButtonFormField<int>(
                          value: _barangId,
                          items: listBarang
                              .map((barang) => DropdownMenuItem(
                                    value: barang.id,
                                    child: Text(barang.nama),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _barangId = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Pilih Barang',
                          ),
                          validator: (value) =>
                              value == null ? 'Barang wajib dipilih' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue:
                              _jumlah != null ? _jumlah.toString() : '',
                          decoration: const InputDecoration(
                            labelText: 'Jumlah',
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) =>
                              _jumlah = int.tryParse(value ?? '0'),
                          validator: (value) =>
                              value!.isEmpty ? 'Jumlah tidak boleh kosong' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue:
                              _harga != null ? _harga!.toStringAsFixed(0) : '',
                          decoration: const InputDecoration(
                            labelText: 'Harga',
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) =>
                              _harga = double.tryParse(value ?? '0'),
                          validator: (value) =>
                              value!.isEmpty ? 'Harga tidak boleh kosong' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _keterangan,
                          decoration: const InputDecoration(
                            labelText: 'Keterangan (opsional)',
                          ),
                          onSaved: (value) => _keterangan = value,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed:
                              stateKeluar is BarangKeluarLoading ? null : _submit,
                          child: stateKeluar is BarangKeluarLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Text(widget.barangKeluar == null ? 'Simpan' : 'Update'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return const Center(child: Text("Gagal memuat barang"));
            },
          );
        },
      ),
    );
  }
}
