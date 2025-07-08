import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:stoktrack_app/features/gudang/data/datasources/gudang_remote_datasource.dart';
import 'package:stoktrack_app/features/gudang/data/repositories/gudang_repository_impl.dart';
import 'package:stoktrack_app/features/gudang/domain/usecase/create_gudang.dart';
import 'package:stoktrack_app/features/gudang/domain/usecase/delete_gudang.dart';
import 'package:stoktrack_app/features/gudang/domain/usecase/update_gudang.dart';
import 'package:stoktrack_app/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:stoktrack_app/features/kategori_barang/data/datasources/kategori_barang_remote_datasource.dart';
import 'package:stoktrack_app/features/kategori_barang/data/repositories/kategori_barang_repository_impl.dart.dart';

import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/domain/usecases/get_profile_usecase.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/dashboard_admin_page.dart';
import 'features/auth/presentation/pages/dashboard_pegawai_page.dart';

// Tambah Bloc Kategori
import 'features/gudang/domain/usecase/get_all_gudang.dart' show GetAllGudang;
import 'features/kategori_barang/presentation/bloc/kategori_barang_bloc.dart';
import 'features/kategori_barang/domain/usecase/get_all_kategori_barang.dart';
import 'features/kategori_barang/domain/usecase/create_kategori_barang.dart';
import 'features/kategori_barang/domain/usecase/update_kategori_barang.dart';
import 'features/kategori_barang/domain/usecase/delete_kategori_barang.dart';
import 'core/api_client.dart';

void main() {
  // Auth setup
  final authRemoteDatasource = AuthRemoteDatasourceImpl(client: http.Client());
  final authRepository = AuthRepositoryImpl(remoteDatasource: authRemoteDatasource);
  final loginUsecase = LoginUsecase(authRepository);
  final registerUsecase = RegisterUsecase(authRepository);
  final getProfileUsecase = GetProfileUsecase(authRepository);

  // ApiClient
  final ApiClient apiClient = ApiClient();
  // Kategori setup
  final kategoriRemoteDatasource = KategoriBarangRemoteDatasourceImpl(client: apiClient);
  final kategoriRepository = KategoriBarangRepositoryImpl(remoteDatasource: kategoriRemoteDatasource);
  final getAllKategoriBarang = GetAllKategoriBarang(kategoriRepository);
  final createKategoriBarang = CreateKategoriBarang(kategoriRepository);
  final updateKategoriBarang = UpdateKategoriBarang(kategoriRepository);
  final deleteKategoriBarang = DeleteKategoriBarang(kategoriRepository);

final gudangRemoteDatasource = GudangRemoteDatasourceImpl(client: apiClient);
final gudangRepository = GudangRepositoryImpl(remoteDatasource: gudangRemoteDatasource);
final getAllGudang = GetAllGudang(gudangRepository);
final createGudang = CreateGudang(gudangRepository);
final updateGudang = UpdateGudang(gudangRepository);
final deleteGudang = DeleteGudang(gudangRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            loginUsecase: loginUsecase,
            registerUsecase: registerUsecase,
            getProfileUsecase: getProfileUsecase,
          ),
        ),
        BlocProvider(
          create: (_) => KategoriBarangBloc(
            getAll: getAllKategoriBarang,
            create: createKategoriBarang,
            update: updateKategoriBarang,
            delete: deleteKategoriBarang,
          ),
        ),
        BlocProvider(
        create: (_) => GudangBloc(
        getAll: getAllGudang,
        create: createGudang,
        update: updateGudang,
        delete: deleteGudang,
  ),
),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> _getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StokTrack',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: _getSavedToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            final token = snapshot.data;
            if (token != null) {
              context.read<AuthBloc>().add(GetProfileEvent(token));
              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is AuthSuccess) {
                    if (state.user.role == 'admin') {
                      return const DashboardAdminPage();
                    } else {
                      return const DashboardPegawaiPage();
                    }
                  } else {
                    return const LoginPage();
                  }
                },
              );
            } else {
              return const LoginPage();
            }
          }
        },
      ),
    );
  }
}
