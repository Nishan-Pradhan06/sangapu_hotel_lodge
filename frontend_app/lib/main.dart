import 'package:flutter/material.dart';
import 'core/init/app_initilizer.dart';
import 'core/theme/app_theme.dart';
import 'routers/app_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Sangapu Hotel and Lodge',
      theme:AppTheme.light,
      routerConfig: appRoute,
    );
  }
}
