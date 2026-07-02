// import 'package:go_router/go_router.dart';
// import '../../common/extension/extension.dart';
// import '../app_routes_names.dart';

// List<GoRoute> authRoutes = [
//   GoRoute(
//     redirect: (context, state) async {
//       final data = await CacheServices.instance.getAuthToken();
//       final roles = await CacheServices.instance.getUserRole();

//       if (data != null) {
//         if (roles == '') {}
//         return AppRoutesName.bottomNavRoutePage.path;
//       }
//       return null;
//     },
//     path: AppRoutesName.loginScreenRoute.path,
//     name: AppRoutesName.loginScreenRoute,

//     builder: (context, state) => LoginPage(),
//   ),
//   GoRoute(
//     path: AppRoutesName.signupScreenRoute.path,
//     name: AppRoutesName.signupScreenRoute,
//     builder: (context, state) => SignupPage(),
//   ),
//   GoRoute(
//     redirect: (context, state) async {
//       final data = await CacheServices.instance.getAuthToken();
//       final roles = await CacheServices.instance.getUserRole();

//       if (data != null) {
//         if (roles == '') {}
//         return AppRoutesName.bottomNavRoutePage.path;
//       }
//       return null;
//     },
//     path: AppRoutesName.verifyEmailScreenRoute.path,
//     name: AppRoutesName.verifyEmailScreenRoute,
//     builder: (context, state) => VerifyEmailPage(email: state.extra as String),
//   ),
// ];
