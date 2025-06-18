import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_stream/presentation/theme/theme_manager.dart';
import 'package:video_stream/presentation/theme/app_colors.dart'; // Import your AppColors
import '../viewModels/splash_viewModel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current theme mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Consumer<SplashViewModel>(
        builder: (context, splashProvider, child) {
          // ✅ SOLUTION 1: Use addPostFrameCallback to defer initialization
          if (!splashProvider.isInitialized && !splashProvider.isLoading && !splashProvider.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _initializeApp(context, splashProvider);
            });
          }

          // ✅ Handle navigation after successful initialization
          if (splashProvider.isInitialized && !splashProvider.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                // context.goNamed('home');
                // context.go(RouteConstants.home);
              }
            });
          }

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDarkMode
                    ? [
                  AppColors.primaryDark,
                  AppColors.primaryDarkVariant,
                ]
                    : [
                  AppColors.primaryLight,
                  AppColors.primaryLightVariant,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppColors.surfaceDark
                          : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(isDarkMode ? 0.3 : 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.video_library,
                      size: 60,
                      color: isDarkMode
                          ? AppColors.primaryDark
                          : AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // App Title
                  Text(
                    'Video Stream',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? AppColors.onBackgroundDark
                          : AppColors.white, // Keep white on gradient background
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Loading Indicator
                  if (splashProvider.isLoading) ...[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDarkMode
                            ? AppColors.secondaryDark
                            : AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      splashProvider.currentTask,
                      style: TextStyle(
                        color: (isDarkMode
                            ? AppColors.onBackgroundDark
                            : AppColors.white).withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                  ],

                  // Success State
                  if (splashProvider.isInitialized && !splashProvider.hasError) ...[
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ready!',
                      style: TextStyle(
                        color: isDarkMode
                            ? AppColors.onBackgroundDark
                            : AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Theme Toggle Button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ThemeManager.toggleTheme();
                        },
                        icon: Icon(
                          isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          size: 20,
                        ),
                        label: Text(
                          isDarkMode ? 'Light Mode' : 'Dark Mode',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode
                              ? AppColors.surfaceDark
                              : AppColors.surfaceLight,
                          foregroundColor: isDarkMode
                              ? AppColors.onSurfaceDark
                              : AppColors.onSurfaceLight,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                              color: isDarkMode
                                  ? AppColors.primaryDark
                                  : AppColors.primaryLight,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],

                  // Error State
                  if (splashProvider.hasError) ...[
                    Icon(
                      Icons.error_outline,
                      color: isDarkMode
                          ? AppColors.errorDark
                          : AppColors.errorLight,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to initialize app',
                      style: TextStyle(
                        color: isDarkMode
                            ? AppColors.onBackgroundDark
                            : AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _retryInitialization(context, splashProvider),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? AppColors.errorDark
                            : AppColors.errorLight,
                        foregroundColor: isDarkMode
                            ? AppColors.onErrorDark
                            : AppColors.onErrorLight,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Initialize the app and handle navigation
  Future<void> _initializeApp(BuildContext context, SplashViewModel splashProvider) async {
    try {
      await splashProvider.initialize();
    } catch (error) {
      // Error is already handled in the provider
      debugPrint('Initialization failed: $error');
    }
  }

  /// Retry initialization
  void _retryInitialization(BuildContext context, SplashViewModel splashProvider) {
    splashProvider.resetState();
    // The initialization will be triggered automatically on next build
  }
}