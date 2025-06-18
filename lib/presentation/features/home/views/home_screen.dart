// 1. Responsive Layout Helper
import 'package:flutter/material.dart';

import '../../../common_widgets/custom_drawer.dart';
import '../../../common_widgets/responsive_layout.dart';
import '../../../common_widgets/responsive_scaffold.dart';

// 5. Usage Example
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentRoute = '/home';

  final List<DrawerItem> drawerItems = [
    const DrawerItem(
      title: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      route: '/home',
    ),
    const DrawerItem(
      title: 'Videos',
      icon: Icons.video_library_outlined,
      selectedIcon: Icons.video_library,
      route: '/videos',
      badgeCount: 5,
    ),
    const DrawerItem(
      title: 'Analytics',
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics,
      route: '/analytics',
      subItems: [
        DrawerItem(
          title: 'Overview',
          icon: Icons.dashboard_outlined,
          selectedIcon: Icons.dashboard,
          route: '/analytics/overview',
        ),
        DrawerItem(
          title: 'Reports',
          icon: Icons.assessment_outlined,
          selectedIcon: Icons.assessment,
          route: '/analytics/reports',
        ),
      ],
    ),
    const DrawerItem(
      title: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      route: '/settings',
    ),
    const DrawerItem(
      title: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      route: '/profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Video Stream App',
      currentRoute: currentRoute,
      drawerItems: drawerItems,
      onDrawerItemTapped: (route) {
        setState(() {
          currentRoute = route;
        });
        // Handle navigation here
        print('Navigating to: $route');
      },
      onLogout: () {
        // Handle logout
        print('Logout pressed');
      },
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Route: $currentRoute',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              ResponsiveLayout.isMobile(context)
                  ? 'Mobile Layout'
                  : 'Desktop Layout',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}