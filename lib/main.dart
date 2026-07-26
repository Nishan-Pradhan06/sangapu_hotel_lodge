import 'package:flutter/material.dart';
import 'package:sangapu/core/widgets/bloc_wrapper_widget.dart';
import 'core/init/app_initilizer.dart';
import 'core/theme/app_theme.dart';
import 'routers/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.init();
  runApp(
    const RestartWidget(
      child: MyApp(),
    ),
  );
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocWrapperWidget(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Sangapu Hotel and Lodge',
        theme: AppTheme.light,
        routerConfig: appRoute,
      ),
    );
  } 
}
