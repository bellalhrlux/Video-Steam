import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_stream/presentation/features/home/views/home_screen.dart';
import 'package:video_stream/presentation/features/splash/views/splash_screen.dart';
import 'package:video_stream/presentation/features/videos/views/video_details_screen.dart';
import 'package:video_stream/presentation/features/videos/views/video_list_screen.dart';
import '../../core/constants/route_constants.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: RouteConstants.splash,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: RouteConstants.splash,
          name: 'splash',
          builder: (context, state) =>  SplashScreen(),
        ),
        GoRoute(
          path: RouteConstants.home,
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RouteConstants.videoList,
          name: 'videoList',
          builder: (context, state) => const VideoListScreen(),
        ),
        GoRoute(
          path: RouteConstants.videoDetails,
          name: 'videoDetails',
          builder: (context, state) {
            final videoId = state.pathParameters[RouteConstants.videoIdParam] ?? '';
            return VideoDetailsScreen(videoId: videoId);
          },
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text(
            'Route not found: ${state.uri.path}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}