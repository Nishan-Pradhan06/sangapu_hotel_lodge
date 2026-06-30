import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lunar_lms/features/auth/blocs/login/log_in_bloc.dart';
import 'package:lunar_lms/features/auth/cubits/cubit/logout_cubit.dart';
import 'package:lunar_lms/features/category/blocs/bloc/category_bloc.dart';
import 'package:lunar_lms/features/category/repository/category_repository.dart';
import 'package:lunar_lms/features/courses/blocs/courses_list/courses_list_bloc.dart';
import 'package:lunar_lms/features/courses/blocs/get_my_courses/get_my_courses_bloc.dart';
import 'package:lunar_lms/features/courses/repository/courses_repository.dart';
import 'package:lunar_lms/features/gobal_pages/settings/cubits/cubit/theme_appearance_cubit.dart';
import 'package:lunar_lms/features/profile/blocs/patch_profile/patch_profile_bloc.dart';
import 'package:lunar_lms/features/profile/blocs/profiles/profile_bloc.dart';
import 'package:lunar_lms/features/profile/repository/profile_repository.dart';
import 'package:retry/retry.dart';

import '../../features/auth/blocs/change_password/change_password_bloc.dart';
import '../../features/auth/blocs/sign_up/sign_up_bloc.dart';
import '../../features/auth/blocs/verify_email/verify_email_bloc.dart';
import '../../features/auth/repository/auth_repository.dart';
import '../../features/gobal_pages/get_started/cubit/getting_starting_cubit.dart';
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
