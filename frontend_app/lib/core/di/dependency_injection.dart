import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:retry/retry.dart';
import '../../features/auth/blocs/login/log_in_bloc.dart';
import '../../features/auth/repository/auth_repository.dart';
import '../../features/rooms/blocs/room_entry/room_entry_bloc.dart';
import '../../features/rooms/repository/room_entry_repository.dart';
import '../../features/statements/bloc/statements_bloc.dart';
import '../../features/statements/repository/transcation_repository.dart';
import '../network/api_services.dart';
import '../network/dio_client.dart';
import '../services/once_cache_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  //###---------------GLOBAL BLOC--------------###

  //###---------------AUTH BLOC---------------------###
  sl.registerLazySingleton(() => LogInBloc(repo: sl()));
  sl.registerLazySingleton(() => RoomEntryBloc(repo: sl()));
  sl.registerLazySingleton(() => StatementsBloc(repo: sl()));

  //###---------------CUBIT--------------------###

  //###---------------REPOSITORY---------------###
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<RoomEntryRepository>(
    () => RoomEntryRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(apiService: sl()),
  );

  //###---------------EXTERNAL REPOSITORY SERVICES---------------###

  sl.registerLazySingleton(() => OnceCacheService());

  sl.registerLazySingleton<ApiService>(
    () => ApiService(sl<Dio>(), sl<RetryOptions>()),
  );
  sl.registerLazySingleton<RetryOptions>(
    () => const RetryOptions(maxAttempts: 3),
  );
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<Dio>(() => sl<DioClient>().dio);
}
