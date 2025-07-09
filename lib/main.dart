import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:stoktrack_app/features/kategori_barang/data/repositories/kategori_barang_repository_impl.dart.dart';

// === CORE ===
import 'core/api_client.dart';

// === AUTH ===
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

// === KATEGORI BARANG ===
import 'features/kategori_barang/data/datasources/kategori_barang_remote_datasource.dart';
import 'features/kategori_barang/domain/usecase/get_all_kategori_barang.dart';
import 'features/kategori_barang/domain/usecase/create_kategori_barang.dart';
import 'features/kategori_barang/domain/usecase/update_kategori_barang.dart';
import 'features/kategori_barang/domain/usecase/delete_kategori_barang.dart';
import 'features/kategori_barang/presentation/bloc/kategori_barang_bloc.dart';

// === GUDANG ===
import 'features/gudang/data/datasources/gudang_remote_datasource.dart';
import 'features/gudang/data/repositories/gudang_repository_impl.dart';
import 'features/gudang/domain/usecase/get_all_gudang.dart';
import 'features/gudang/domain/usecase/create_gudang.dart';
import 'features/gudang/domain/usecase/update_gudang.dart';
import 'features/gudang/domain/usecase/delete_gudang.dart';
import 'features/gudang/presentation/bloc/gudang_bloc.dart';

// === BARANG ===
import 'features/barang/data/datasources/barang_remote_datasource.dart';
import 'features/barang/data/repositories/barang_repository_impl.dart';
import 'features/barang/domain/usecases/get_all_barang.dart';
import 'features/barang/domain/usecases/create_barang.dart';
import 'features/barang/domain/usecases/update_barang.dart';
import 'features/barang/domain/usecases/delete_barang.dart';
import 'features/barang/domain/usecases/upload_gambar_barang.dart';
import 'features/barang/presentation/bloc/barang_bloc.dart';

// === KATEGORI MAKANAN === 
import 'features/kategori_makanan/data/datasources/kategori_makanan_remote_datasource.dart';
import 'features/kategori_makanan/data/repositories/kategori_makanan_repository_impl.dart';
import 'features/kategori_makanan/domain/usecases/get_all_kategori_makanan.dart';
import 'features/kategori_makanan/domain/usecases/create_kategori_makanan.dart';
import 'features/kategori_makanan/domain/usecases/update_kategori_makanan.dart';
import 'features/kategori_makanan/domain/usecases/delete_kategori_makanan.dart';
import 'features/kategori_makanan/presentation/bloc/kategori_makanan_bloc.dart';

// == KATEGORI MINUMAN ===
import 'features/kategori_minuman/data/datasources/kategori_minuman_remote_datasource.dart';
import 'features/kategori_minuman/data/repositories/kategori_minuman_repository_impl.dart';
import 'features/kategori_minuman/domain/usecases/get_all_kategori_minuman.dart';
import 'features/kategori_minuman/domain/usecases/create_kategori_minuman.dart';
import 'features/kategori_minuman/domain/usecases/update_kategori_minuman.dart';
import 'features/kategori_minuman/domain/usecases/delete_kategori_minuman.dart';
import 'features/kategori_minuman/presentation/bloc/kategori_minuman_bloc.dart';
void main() {
  final apiClient = ApiClient();

  // === AUTH ===
  final authRemoteDatasource = AuthRemoteDatasourceImpl(client: http.Client());
  final authRepository = AuthRepositoryImpl(remoteDatasource: authRemoteDatasource);
  final loginUsecase = LoginUsecase(authRepository);
  final registerUsecase = RegisterUsecase(authRepository);
  final getProfileUsecase = GetProfileUsecase(authRepository);

  // === KATEGORI BARANG ===
  final kategoriRemoteDatasource = KategoriBarangRemoteDatasourceImpl(client: apiClient);
  final kategoriRepository = KategoriBarangRepositoryImpl(remoteDatasource: kategoriRemoteDatasource);
  final getAllKategoriBarang = GetAllKategoriBarang(kategoriRepository);
  final createKategoriBarang = CreateKategoriBarang(kategoriRepository);
  final updateKategoriBarang = UpdateKategoriBarang(kategoriRepository);
  final deleteKategoriBarang = DeleteKategoriBarang(kategoriRepository);

  // === GUDANG ===
  final gudangRemoteDatasource = GudangRemoteDatasourceImpl(client: apiClient);
  final gudangRepository = GudangRepositoryImpl(remoteDatasource: gudangRemoteDatasource);
  final getAllGudang = GetAllGudang(gudangRepository);
  final createGudang = CreateGudang(gudangRepository);
  final updateGudang = UpdateGudang(gudangRepository);
  final deleteGudang = DeleteGudang(gudangRepository);

  // === BARANG ===
  final barangRemoteDatasource = BarangRemoteDatasourceImpl(apiClient: apiClient);
  final barangRepository = BarangRepositoryImpl(remoteDatasource: barangRemoteDatasource);
  final getAllBarang = GetAllBarang(barangRepository);
  final createBarang = CreateBarang(barangRepository);
  final updateBarang = UpdateBarang(barangRepository);
  final deleteBarang = DeleteBarang(barangRepository);
  final uploadGambar = UploadGambarBarang(barangRepository);

  // === KATEGORI MAKANAN === 
  final kategoriMakananRemoteDatasource = KategoriMakananRemoteDatasourceImpl(apiClient: apiClient);
  final kategoriMakananRepository = KategoriMakananRepositoryImpl(remoteDatasource: kategoriMakananRemoteDatasource);
  final getAllKategoriMakanan = GetAllKategoriMakanan(kategoriMakananRepository);
  final createKategoriMakanan = CreateKategoriMakanan(kategoriMakananRepository);
  final updateKategoriMakanan = UpdateKategoriMakanan(kategoriMakananRepository);
  final deleteKategoriMakanan = DeleteKategoriMakanan(kategoriMakananRepository);

  // === KATEGORI MINUMAN === 
  final kategoriMinumanRemoteDatasource = KategoriMinumanRemoteDatasourceImpl(apiClient: apiClient);
  final kategoriMinumanRepository = KategoriMinumanRepositoryImpl(remoteDatasource: kategoriMinumanRemoteDatasource);
  final getAllKategoriMinuman = GetAllKategoriMinuman(kategoriMinumanRepository);
  final createKategoriMinuman = CreateKategoriMinuman(kategoriMinumanRepository);
  final updateKategoriMinuman = UpdateKategoriMinuman(kategoriMinumanRepository);
  final deleteKategoriMinuman = DeleteKategoriMinuman(kategoriMinumanRepository);

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
        BlocProvider(
          create: (_) => BarangBloc(
            getAllBarang: getAllBarang,
            createBarang: createBarang,
            updateBarang: updateBarang,
            deleteBarang: deleteBarang,
            uploadGambarBarang: uploadGambar,
          ),
        ),
        BlocProvider(
          create: (_) => KategoriMakananBloc(
            getAll: getAllKategoriMakanan,
            create: createKategoriMakanan,
            update: updateKategoriMakanan,
            delete: deleteKategoriMakanan,
          ),
        ),
        BlocProvider(
            create: (_) => KategoriMinumanBloc(
            getAll: getAllKategoriMinuman,
            create: createKategoriMinuman,
            update: updateKategoriMinuman,
            delete: deleteKategoriMinuman,
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
