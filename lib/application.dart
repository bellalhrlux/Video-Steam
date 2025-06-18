import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_stream/presentation/features/splash/viewModels/splash_viewModel.dart';
import 'package:video_stream/presentation/router/app_router.dart';
import 'package:video_stream/presentation/theme/app_theme.dart';
import 'package:video_stream/presentation/theme/theme_manager.dart';
// Import other providers as needed

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  // Create AppRouter instance
  final _appRouter = AppRouter();

  // // Theme mode state
  // final ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier(
  //   ThemeMode.light,
  // );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ThemeManager.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Splash Provider
        ChangeNotifierProvider(create: (context) => SplashViewModel()),
        // Add other providers here
        // ChangeNotifierProvider(create: (context) => VideoProvider()),
        // ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeManager.themeNotifier,
        builder: (context, ThemeMode themeMode, child) {
          return MaterialApp.router(
            title: 'Flutter Clean Architecture',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: _appRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
   // _themeNotifier.dispose();
    super.dispose();
  }
}
