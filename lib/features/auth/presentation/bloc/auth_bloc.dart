import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Tambah ini
import 'package:stoktrack_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:stoktrack_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:stoktrack_app/features/auth/domain/usecases/get_profile_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final GetProfileUsecase getProfileUsecase;

  AuthBloc({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.getProfileUsecase,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUsecase(event.email, event.password);

        // ✅ SIMPAN TOKEN JWT di SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', user.token);

        emit(AuthSuccess(user: user));
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await registerUsecase(
          event.name,
          event.email,
          event.password,
        );

        // ✅ SIMPAN TOKEN JWT kalau register auto-login
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', user.token);

        emit(AuthSuccess(user: user));
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    });

    on<GetProfileEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await getProfileUsecase(event.token);
        emit(AuthSuccess(user: user));
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    });
  }
}

