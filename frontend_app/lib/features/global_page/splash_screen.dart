import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/extension/extension.dart';
import '../../core/services/cache_service.dart';
import '../../routers/app_routes_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await CacheServices.instance.getAuthToken();

    if (!mounted) return;

    context.go(
      token != null
          ? AppRoutesName.bottomNavRoutePage.path
          : AppRoutesName.loginScreenRoute.path,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/logo/logo.png', width: 150, height: 150),
                const SizedBox(height: 20),
                const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'The Goat Tech',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
