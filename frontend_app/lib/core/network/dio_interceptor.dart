import 'package:dio/dio.dart';
import '../widgets/custom_toast.dart';
import '../../common/logger.dart';
import '../../routers/app_routes_names.dart';
import '../services/cache_service.dart';
import '../services/navigation_service.dart';

class AppDioInterceptor extends Interceptor {
  final List<String> _noAuthPaths = [
    "auth/login/",
    "auth/signup/",
    "auth/forgot-password/",
  ];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String path = options.uri.path;

    // Skip adding token for auth endpoints
    if (_noAuthPaths.any((e) => path.contains(e))) {
      return handler.next(options);
    }

    // Add token for all other endpoints
    final String? token = await CacheServices.instance.getAuthToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final int? statusCode = err.response?.statusCode;
    final String path = err.requestOptions.uri.path;

    dLog.d("[Error] ${statusCode ?? 'Unknown Status'} on $path");

    if (statusCode == 401) {
      // Token expired → logout user

      await CacheServices.instance.clearAll();

      CustomToast.showError("Session Expired !!! Please Login again.");

      NavigationService().goNamed(AppRoutesName.loginScreenRoute);
    }

    return handler.next(err);
  }
}
