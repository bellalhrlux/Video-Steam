// 4. Responsive Scaffold with Drawer
import 'package:flutter/material.dart';
import 'package:video_stream/presentation/common_widgets/responsive_layout.dart';

import '../theme/theme_manager.dart';
import 'custom_drawer.dart';

class ResponsiveScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<DrawerItem> drawerItems;
  final String currentRoute;
  final Function(String route) onDrawerItemTapped;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool showDrawer;
  final VoidCallback? onLogout;

  const ResponsiveScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.drawerItems,
    required this.currentRoute,
    required this.onDrawerItemTapped,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.showDrawer = true,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (ResponsiveLayout.isLargeScreen(context) && showDrawer) {
      return Scaffold(
        backgroundColor: colorScheme.background,
        body: Row(
          children: [
            // Fixed Drawer for large screens
            ResponsiveDrawer(
              drawerItems: drawerItems,
              currentRoute: currentRoute,
              onItemTapped: onDrawerItemTapped,
              onLogout: onLogout,
            ),
            // Main content
            Expanded(
              child: Column(
                children: [
                  // App Bar
                  AppBar(
                    title: Text(title),
                    automaticallyImplyLeading: false,
                    actions: [
                      ...?actions,
                      // Theme toggle button
                      IconButton(
                        onPressed: ThemeManager.toggleTheme,
                        icon: Icon(
                          theme.brightness == Brightness.dark
                              ? Icons.light_mode
                              : Icons.dark_mode,
                        ),
                      ),
                    ],
                  ),
                  // Body
                  Expanded(child: body),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: floatingActionButton,
      );
    } else {
      // Mobile layout with drawer
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            ...?actions,
            // Theme toggle button
            IconButton(
              onPressed: ThemeManager.toggleTheme,
              icon: Icon(
                theme.brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            ),
          ],
        ),
        drawer: showDrawer
            ? ResponsiveDrawer(
          drawerItems: drawerItems,
          currentRoute: currentRoute,
          onItemTapped: onDrawerItemTapped,
          onLogout: onLogout,
        )
            : null,
        body: body,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
      );
    }
  }
}