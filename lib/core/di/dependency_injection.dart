import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../network/api_services.dart';
import '../network/dio_client.dart';
import '../services/once_cache_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  //###---------------GLOBAL BLOC--------------###

  //###---------------AUTH BLOC---------------------###

  sl.registerLazySingleton(() => SignUpBloc(repo: sl()));
  sl.registerLazySingleton(() => LogInBloc(repo: sl()));
  sl.registerLazySingleton(() => VerifyEmailBloc(repo: sl()));
  sl.registerLazySingleton(() => ChangePasswordBloc(repo: sl()));

  //###---------------PROFILE BLOC---------------------###
  sl.registerLazySingleton(() => ProfileBloc(repo: sl()));
  sl.registerLazySingleton(() => PatchProfileBloc(repo: sl()));

  //###---------------CATEGORY BLOC---------------------###
  sl.registerLazySingleton(() => CategoryBloc(repo: sl()));

  //###---------------COURSES BLOC---------------------###
  sl.registerLazySingleton(() => GetMyCoursesBloc(repo: sl()));
  sl.registerLazySingleton(() => CoursesListBloc(repo: sl()));

  //###---------------CUBIT--------------------###
  sl.registerLazySingleton(() => GettingStartedCubit(onceCacheService: sl()));
  sl.registerLazySingleton(() => ThemeAppearanceCubit(onceCacheService: sl()));
  sl.registerLazySingleton(() => LogoutCubit(repo: sl()));

  //###---------------REPOSITORY---------------###
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<CoursesRepository>(
    () => CoursesRepositoryImpl(apiService: sl()),
  );

  //###---------------FEATURE BLOCS---------------------###
  // sl.registerFactory(() => AvailabilityBloc(repository: sl()));

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
