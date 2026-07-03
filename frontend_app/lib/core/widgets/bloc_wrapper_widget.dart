import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/blocs/login/log_in_bloc.dart';
import '../../features/rooms/blocs/room_entry/room_entry_bloc.dart';
import '../../features/statements/bloc/statements_bloc.dart';
import '../di/dependency_injection.dart';
// import '../services/once_cache_service.dart';

class BlocWrapperWidget extends StatelessWidget {
  final Widget child;
  const BlocWrapperWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LogInBloc>()),
        BlocProvider(create: (_) => sl<RoomEntryBloc>()),
        BlocProvider(create: (_) => sl<StatementsBloc>()),

        //##----------GET------------##//
      ],
      child: child,
    );
  }
}
