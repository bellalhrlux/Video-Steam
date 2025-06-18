import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:video_stream/presentation/theme/theme_manager.dart';
import 'package:video_stream/presentation/theme/app_colors.dart'; // Import your AppColors
import '../viewModels/splash_viewModel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Consumer<SplashViewModel>(
        builder: (context, splashProvider, child) {
          // Initialize app
          if (!splashProvider.isInitialized && !splashProvider.isLoading && !splashProvider.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _initializeApp(context, splashProvider);
            });
          }

          // Handle navigation
          if (splashProvider.isInitialized && !splashProvider.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                // Navigate to home
                context.goNamed('home');
                // context.go(RouteConstants.home);
              }
            });
          }

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colorScheme.gradientStart,
                  colorScheme.gradientEnd,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo
                  _buildAppLogo(context),
                  const SizedBox(height: 30),

                  // App Title
                  Text(
                    'Video Stream',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onError,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Dynamic content based on state
                  _buildContent(context, splashProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppLogo(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: colorScheme.cardShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        Icons.video_library,
        size: 60,
        color: colorScheme.primary,
      ),
    );
  }

  Widget _buildContent(BuildContext context, SplashViewModel splashProvider) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (splashProvider.isLoading) {
      return Column(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.secondary),
          ),
          const SizedBox(height: 20),
          Text(
            splashProvider.currentTask,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onPrimary.withOpacity(0.7),
            ),
          ),
        ],
      );
    }

    if (splashProvider.isInitialized && !splashProvider.hasError) {
      return Column(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Ready!',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 20),
          _buildThemeToggleButton(context),

        ],
      );
    }

    if (splashProvider.hasError) {
      return Column(
        children: [
          Icon(
            Icons.error_outline,
            color: colorScheme.error,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to initialize app',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _retryInitialization(context, splashProvider),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
            ),
            child: const Text('Retry'),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildThemeToggleButton(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return ElevatedButton.icon(
      onPressed: ThemeManager.toggleTheme,
      icon: Icon(
        isDarkMode ? Icons.light_mode : Icons.dark_mode,
        size: 20,
      ),
      label: Text(
        isDarkMode ? 'Light Mode' : 'Dark Mode',
        style: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        side: BorderSide(
          color: colorScheme.primary,
          width: 2,
        ),
      ),
    );
  }

  Future<void> _initializeApp(BuildContext context, SplashViewModel splashProvider) async {
    try {
      await splashProvider.initialize();
    } catch (error) {
      debugPrint('Initialization failed: $error');
    }
  }

  void _retryInitialization(BuildContext context, SplashViewModel splashProvider) {
    splashProvider.resetState();
  }
}

// 4. Reusable Theme-aware Widgets
class ThemeAwareCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const ThemeAwareCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.cardShadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

// 5. Theme Utility Class
class ThemeUtils {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static ColorScheme colorScheme(BuildContext context) {
    return Theme.of(context).colorScheme;
  }

  static TextTheme textTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  // Get adaptive color based on theme
  static Color adaptiveColor(BuildContext context, Color lightColor, Color darkColor) {
    return isDarkMode(context) ? darkColor : lightColor;
  }

  // Get contrast color for better readability
  static Color getContrastColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
