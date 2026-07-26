import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:retry/retry.dart';
import 'package:sangapu/features/auth/cubits/logout/logout_cubit.dart';
import 'package:sangapu/features/auth/cubits/remember_me/remember_me_cubit.dart';
import 'package:sangapu/features/banners/blocs/get_banner/get_banner_bloc.dart';
import 'package:sangapu/features/banners/repository/banner_repository.dart';
import 'package:sangapu/features/expenses/blocs/add_expenses/add_expenses_record_bloc.dart';
import 'package:sangapu/features/expenses/blocs/edit_expenses/edit_expenses_bloc.dart';
import 'package:sangapu/features/expenses/blocs/get_expenses/get_expenses_bloc.dart';
import 'package:sangapu/features/income/blocs/edit_room_entry/edit_income_entry_bloc.dart';
import 'package:sangapu/features/income/blocs/income_entry/income_entry_bloc.dart';
import '../../../../features/auth/blocs/login/log_in_bloc.dart';
import '../../../../features/auth/repository/auth_repository.dart';
import '../../../../features/expenses/repository/expenses_repository.dart';
import '../../../../features/income/blocs/bloc/get_income_bloc.dart';
import '../../../../features/income/repository/income_repository.dart';
import '../../../../features/statements/bloc/statements_bloc.dart';
import '../../../../features/export_statements/blocs/export_excel/export_statement_bloc.dart';
import '../../../../features/export_statements/blocs/export_pdf/export_pdf_bloc.dart';
import '../../../../features/export_statements/repository/export_statement_repository.dart';
import '../../../../features/statements/cubits/statement_filter_cubit.dart';
import '../../../../features/statements/repository/transcation_repository.dart';
import '../network/api_services.dart';
import '../network/dio_client.dart';
import '../services/once_cache_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  //###---------------GLOBAL BLOC--------------###

  //###---------------AUTH BLOC---------------------###
  sl.registerFactory(() => LogInBloc(repo: sl()));
  sl.registerFactory(() => IncomeEntryBloc(repo: sl()));
  sl.registerFactory(() => StatementsBloc(repo: sl()));
  sl.registerFactory(() => GetExpensesBloc(repo: sl()));
  sl.registerFactory(() => AddExpensesRecordBloc(repo: sl()));
  sl.registerFactory(() => GetIncomeBloc(repo: sl()));
  sl.registerFactory(() => ExportStatementBloc(repo: sl()));
  sl.registerFactory(() => ExportPdfBloc(repo: sl()));
  sl.registerFactory(() => EditExpensesBloc(repo: sl()));
  sl.registerFactory(() => EditIncomeEntryBloc(repo: sl()));
  sl.registerFactory(() => StatementFilterCubit());
  sl.registerFactory(() => GetBannerBloc(repo: sl()));

  //###---------------CUBIT--------------------###
  sl.registerFactory(() => LogoutCubit(repo: sl()));
  sl.registerFactory(() => RememberMeCubit());

  //###---------------REPOSITORY---------------###
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(apiService: sl()),
  );

  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<ExpensesRepository>(
    () => ExpensesRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<IncomeRepository>(
    () => IncomeRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<ExportStatementRepository>(
    () => ExportStatementRepositoryImpl(apiService: sl()),
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
