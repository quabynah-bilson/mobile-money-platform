import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get_it/get_it.dart';
import 'package:momo/features/auth/data/repositories/auth.dart';
import 'package:momo/features/auth/domain/repositories/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupInjector() async {
  /// shared preferences
  getIt.registerFactoryAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  /// http connection
  getIt.registerFactory(
    () => Dio(
      BaseOptions(
        baseUrl: FlutterConfig.get('BASE_URL'),
        connectTimeout: 6000,
        contentType: 'application/json',
        maxRedirects: 3,
        sendTimeout: 6000,
      ),
    ),
  );

  /// register repositories
  getIt.registerLazySingleton<BaseAuthRepository>(() => AuthRepository());
}
