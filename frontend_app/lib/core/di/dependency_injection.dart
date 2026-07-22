import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:retry/retry.dart';
import 'package:sangapu/features/auth/cubits/cubit/logout_cubit.dart';
import 'package:sangapu/features/expenses/blocs/add_expenses/add_expenses_record_bloc.dart';
import 'package:sangapu/features/expenses/blocs/edit_expenses/edit_expenses_bloc.dart';
import 'package:sangapu/features/expenses/blocs/get_expenses/get_expenses_bloc.dart';
import 'package:sangapu/features/rooms/blocs/edit_room_entry/edit_room_entry_bloc.dart';
import '../../../../features/auth/blocs/login/log_in_bloc.dart';
import '../../../../features/auth/repository/auth_repository.dart';
import '../../../../features/expenses/repository/expenses_repository.dart';
import '../../../../features/income/blocs/bloc/get_income_bloc.dart';
import '../../../../features/income/repository/income_repository.dart';
import '../../../../features/rooms/blocs/room_entry/room_entry_bloc.dart';
import '../../../../features/rooms/repository/room_entry_repository.dart';
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
  sl.registerLazySingleton(() => LogInBloc(repo: sl()));
  sl.registerLazySingleton(() => RoomEntryBloc(repo: sl()));
  sl.registerLazySingleton(() => StatementsBloc(repo: sl()));
  sl.registerLazySingleton(() => GetExpensesBloc(repo: sl()));
  sl.registerLazySingleton(() => AddExpensesRecordBloc(repo: sl()));
  sl.registerLazySingleton(() => GetIncomeBloc(repo: sl()));
  sl.registerLazySingleton(() => ExportStatementBloc(repo: sl()));
  sl.registerLazySingleton(() => ExportPdfBloc(repo: sl()));
  sl.registerLazySingleton(() => EditExpensesBloc(repo: sl()));
  sl.registerLazySingleton(() => EditRoomEntryBloc(repo: sl()));
  sl.registerLazySingleton(() => StatementFilterCubit());

  //###---------------CUBIT--------------------###
  sl.registerLazySingleton(() => LogoutCubit(repo: sl()));

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
