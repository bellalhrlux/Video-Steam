// 1. Responsive Layout Helper
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/custom_drawer.dart';
import '../../../common_widgets/responsive_layout.dart';
import '../../../common_widgets/responsive_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentRoute = '/home';

  final ScrollController _scrollController = ScrollController();

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

  var list = ["hzi057IFXv8", "WT9-4DXUqsM"];

  var loadingMore = false;
  var totalItemCount = 100;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !loadingMore) {
        // Reached near the bottom of the GridView
        debugPrint("Scroll End.....");
        _loadMoreItem();
      }
    });
  }

  _loadMoreItem() async {
    loadingMore = true;

    setState(() {});

    await Future.delayed(Duration(seconds: 2), () {
      loadingMore = false;
      setState(() {
        totalItemCount += 100;
      });
    });
  }

  //https://img.youtube.com/vi/hzi057IFXv8/0.jpg

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveLayout.getPadding(context);
    final crossAxisItemCount = ResponsiveLayout.getCrossAxisItemCount(context);
    final aspectRatio = ResponsiveLayout.getAspectRatio(context);

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
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: totalItemCount,
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisItemCount,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                      Random().nextInt(256),
                      Random().nextInt(256),
                      Random().nextInt(256),
                      .7,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text("${index + 1}")),
                  /* child:   ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                "https://img.youtube.com/vi/${list[index % 2 == 0 ? 0 : 1]}/0.jpg",
              ),
            )*/
                );
              },
            ),
          ),
          //if (loadingMore)
            AnimatedContainer(
              height: loadingMore?30:0,
              width: loadingMore?30:0,
              duration: Duration(milliseconds: 300),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
