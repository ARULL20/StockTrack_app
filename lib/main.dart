import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

void main() {
  // Inisialisasi dependency di root
  final authRemoteDatasource = AuthRemoteDatasourceImpl(client: http.Client());
  final authRepository = AuthRepositoryImpl(remoteDatasource: authRemoteDatasource);
  final loginUsecase = LoginUsecase(authRepository);
  final registerUsecase = RegisterUsecase(authRepository);
  final getProfileUsecase = GetProfileUsecase(authRepository);

  runApp(
    BlocProvider(
      create: (_) => AuthBloc(
        loginUsecase: loginUsecase,
        registerUsecase: registerUsecase,
        getProfileUsecase: getProfileUsecase,
      ),
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
