import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';



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
import 'package:stoktrack_app/features/auth/presentation/pages/welcome_page.dart';


// === KATEGORI BARANG ===
import 'features/kategori_barang/data/datasources/kategori_barang_remote_datasource.dart';
import 'features/kategori_barang/domain/usecase/get_all_kategori_barang.dart';
import 'features/kategori_barang/domain/usecase/create_kategori_barang.dart';
import 'features/kategori_barang/domain/usecase/update_kategori_barang.dart';
import 'features/kategori_barang/domain/usecase/delete_kategori_barang.dart';
import 'features/kategori_barang/presentation/bloc/kategori_barang_bloc.dart';
import 'package:stoktrack_app/features/kategori_barang/data/repositories/kategori_barang_repository_impl.dart.dart';


// === GUDANG ===
import 'features/gudang/data/datasources/gudang_remote_datasource.dart';
import 'features/gudang/data/repositories/gudang_repository_impl.dart';
import 'features/gudang/domain/usecase/get_all_gudang.dart';
import 'features/gudang/domain/usecase/create_gudang.dart';
import 'features/gudang/domain/usecase/update_gudang.dart';
import 'features/gudang/domain/usecase/delete_gudang.dart';
import 'features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:stoktrack_app/features/gudang/presentation/pages/pick_location_page.dart';


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

// === KATEGORI MINUMAN ===
import 'features/kategori_minuman/data/datasources/kategori_minuman_remote_datasource.dart';
import 'features/kategori_minuman/data/repositories/kategori_minuman_repository_impl.dart';
import 'features/kategori_minuman/domain/usecases/get_all_kategori_minuman.dart';
import 'features/kategori_minuman/domain/usecases/create_kategori_minuman.dart';
import 'features/kategori_minuman/domain/usecases/update_kategori_minuman.dart';
import 'features/kategori_minuman/domain/usecases/delete_kategori_minuman.dart';
import 'features/kategori_minuman/presentation/bloc/kategori_minuman_bloc.dart';
import 'package:stoktrack_app/features/minuman/presentation/bloc/minuman_bloc.dart';
import 'package:stoktrack_app/features/minuman/presentation/pages/minuman_form_page.dart';

// === MAKANAN ===
import 'features/makanan/data/repositories/makanan_repository_impl.dart';
import 'features/makanan/domain/usecases/get_all_makanan.dart';
import 'features/makanan/domain/usecases/create_makanan.dart';
import 'features/makanan/domain/usecases/update_makanan.dart';
import 'features/makanan/domain/usecases/delete_makanan.dart';
import 'features/makanan/presentation/bloc/makanan_bloc.dart';
import 'features/makanan/presentation/pages/makanan_form_page.dart';
import 'package:stoktrack_app/features/makanan/data/datasources/makanan_remote_datasource.dart';
import 'package:stoktrack_app/features/makanan/domain/usecases/upload_gambar_makanan.dart';

// === MINUMAN ===
import 'features/minuman/data/repositories/minuman_repository_impl.dart';
import 'features/minuman/domain/usecases/get_all_minuman.dart';
import 'features/minuman/domain/usecases/create_minuman.dart';
import 'features/minuman/domain/usecases/update_minuman.dart';
import 'features/minuman/domain/usecases/delete_minuman.dart';
import 'package:stoktrack_app/features/minuman/data/datasources/minuman_remote_datasource.dart';
import 'features/minuman/domain/usecases/upload_gambar_minuman.dart';
import 'package:stoktrack_app/features/minuman/domain/usecases/upload_gambar_minuman.dart';




// === BARANG KELUAR ===
import 'features/barang_keluar/data/repositories/barang_keluar_repository_impl.dart';
import 'features/barang_keluar/domain/usecases/get_all_barang_keluar.dart';
import 'features/barang_keluar/domain/usecases/create_barang_keluar.dart';
import 'features/barang_keluar/domain/usecases/update_barang_keluar.dart';
import 'features/barang_keluar/domain/usecases/delete_barang_keluar.dart';
import 'features/barang_keluar/presentation/bloc/barang_keluar_bloc.dart';
import 'package:stoktrack_app/features/barang_keluar/data/datasources/barang_keluar_remote_data_source.dart';

// === LAPORAN ===
import 'features/laporan/data/datasources/laporan_remote_datasource.dart';
import 'features/laporan/data/repositories/laporan_repository_impl.dart';
import 'features/laporan/domain/usecase/get_pemasukan_total.dart';
import 'features/laporan/domain/usecase/get_pengeluaran_total.dart';
import 'features/laporan/presentation/bloc/laporan_bloc.dart';


void main() {
  final apiClient = ApiClient();

  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api',
      headers: {'Accept': 'application/json'},
    ),
  );

  // === AUTH ===
  final authRemoteDatasource = AuthRemoteDatasourceImpl(dio: dio);
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

  // === MAKANAN ===
  final makananRemoteDatasource = MakananRemoteDatasourceImpl(apiClient: apiClient);
  final makananRepository = MakananRepositoryImpl(remoteDatasource: makananRemoteDatasource);
  final getAllMakanan = GetAllMakanan(makananRepository);
  final createMakanan = CreateMakanan(makananRepository);
  final updateMakanan = UpdateMakanan(makananRepository);
  final deleteMakanan = DeleteMakanan(makananRepository);
  final uploadGambarMakanan = UploadGambarMakanan(makananRepository);


  // === MINUMAN ===
  // === MINUMAN ===
  final minumanRemoteDatasource = MinumanRemoteDatasourceImpl(apiClient: apiClient);
  final minumanRepository = MinumanRepositoryImpl(remoteDatasource: minumanRemoteDatasource);
  final getAllMinuman = GetAllMinuman(minumanRepository);
  final createMinuman = CreateMinuman(minumanRepository);
  final updateMinuman = UpdateMinuman(minumanRepository);
  final deleteMinuman = DeleteMinuman(minumanRepository);
  final uploadGambarMinuman = UploadGambarMinuman(minumanRepository);

    // === BARANG KELUAR ===
  final barangKeluarRemoteDatasource = BarangKeluarRemoteDatasourceImpl(apiClient: apiClient);
  final barangKeluarRepository = BarangKeluarRepositoryImpl(remoteDatasource: barangKeluarRemoteDatasource);
  final getAllBarangKeluar = GetAllBarangKeluar(barangKeluarRepository);
  final createBarangKeluar = CreateBarangKeluar(barangKeluarRepository);
  final updateBarangKeluar = UpdateBarangKeluar(barangKeluarRepository);
  final deleteBarangKeluar = DeleteBarangKeluar(barangKeluarRepository);

// === LAPORAN ===
  final laporanRemoteDatasource = LaporanRemoteDatasource(dio: dio);
  final laporanRepository = LaporanRepositoryImpl(remoteDatasource: laporanRemoteDatasource);
  final getPemasukanTotal = GetPemasukanTotal(laporanRepository);
  final getPengeluaranTotal = GetPengeluaranTotal(laporanRepository);


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
       BlocProvider(
          create: (_) => MakananBloc(
            getAllMakanan: getAllMakanan,
            createMakanan: createMakanan,
            updateMakanan: updateMakanan,
            deleteMakanan: deleteMakanan,
            uploadGambarMakanan: uploadGambarMakanan,
          ),
        ),

         BlocProvider(
          create: (_) => MinumanBloc(
            getAllMinuman: getAllMinuman,
            createMinuman: createMinuman,
            updateMinuman: updateMinuman,
            deleteMinuman: deleteMinuman,
            uploadGambarMinuman: uploadGambarMinuman,
          ),
        ),
        BlocProvider(
          create: (_) => BarangKeluarBloc(
            getAll: getAllBarangKeluar,
            create: createBarangKeluar,
            update: updateBarangKeluar,
            delete: deleteBarangKeluar,
          ),
        ),
        BlocProvider(
          create: (_) => LaporanBloc(
            getPemasukanTotal: getPemasukanTotal,
            getPengeluaranTotal: getPengeluaranTotal,
            laporanRepository: laporanRepository,
          ),
        ),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _token;
  bool _profileFetched = false;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    setState(() {
      _token = token;
    });
    if (token != null && !_profileFetched) {
      context.read<AuthBloc>().add(GetProfileEvent(token));
      _profileFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_token == null) {
      return const MaterialApp(home: WelcomePage());
    }

    return MaterialApp(
      title: 'StokTrack',
      debugShowCheckedModeBanner: false,
      routes: {
        '/pick-location': (context) => const PickLocationPage(),
        '/makanan-form': (context) => const MakananFormPage(),
        '/minuman-form': (context) => const MinumanFormPage(),
      },
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is AuthSuccess) {
            return state.user.role == 'admin'
                ? const DashboardAdminPage()
                : const DashboardPegawaiPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}