import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunar_lms/features/auth/cubits/cubit/logout_cubit.dart';
import 'package:lunar_lms/features/courses/blocs/courses_list/courses_list_bloc.dart';
import 'package:lunar_lms/features/gobal_pages/settings/cubits/cubit/theme_appearance_cubit.dart';

import '../../features/auth/blocs/change_password/change_password_bloc.dart';
import '../../features/auth/blocs/login/log_in_bloc.dart';
import '../../features/auth/blocs/sign_up/sign_up_bloc.dart';
import '../../features/auth/blocs/verify_email/verify_email_bloc.dart';
import '../../features/category/blocs/bloc/category_bloc.dart';
import '../../features/courses/blocs/get_my_courses/get_my_courses_bloc.dart';
import '../../features/gobal_pages/get_started/cubit/getting_starting_cubit.dart';
import '../../features/profile/blocs/patch_profile/patch_profile_bloc.dart';
import '../../features/profile/blocs/profiles/profile_bloc.dart';
import '../di/dependency_injection.dart';

// import '../di/dependency_injection.dart';
// import '../services/once_cache_service.dart';

class BlocWrapperWidget extends StatelessWidget {
  final Widget child;
  const BlocWrapperWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LogInBloc>()),
        BlocProvider(create: (_) => sl<SignUpBloc>()),
        BlocProvider(create: (_) => sl<VerifyEmailBloc>()),
        BlocProvider(create: (_) => sl<ChangePasswordBloc>()),
        BlocProvider(create: (_) => sl<GettingStartedCubit>()),
        BlocProvider(create: (_) => sl<PatchProfileBloc>()),
        BlocProvider(create: (_) => sl<ThemeAppearanceCubit>()),
        BlocProvider(create: (_) => sl<LogoutCubit>()),

        //##----------GET------------##//
        BlocProvider(create: (_) => sl<CategoryBloc>()),
        BlocProvider(create: (_) => sl<ProfileBloc>()),
        BlocProvider(create: (_) => sl<GetMyCoursesBloc>()),
        BlocProvider(create: (_) => sl<CoursesListBloc>()),
      ],
      child: child,
    );
  }
}
