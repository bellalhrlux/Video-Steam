import 'package:flutter/material.dart';
import 'package:video_stream/presentation/common_widgets/responsive_layout.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final IconData? selectedIcon;
  final String route;
  final List<DrawerItem>? subItems;
  final bool isSelected;
  final int? badgeCount;

  const DrawerItem({
    required this.title,
    required this.icon,
    this.selectedIcon,
    required this.route,
    this.subItems,
    this.isSelected = false,
    this.badgeCount,
  });

  DrawerItem copyWith({
    String? title,
    IconData? icon,
    IconData? selectedIcon,
    String? route,
    List<DrawerItem>? subItems,
    bool? isSelected,
    int? badgeCount,
  }) {
    return DrawerItem(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      route: route ?? this.route,
      subItems: subItems ?? this.subItems,
      isSelected: isSelected ?? this.isSelected,
      badgeCount: badgeCount ?? this.badgeCount,
    );
  }
}


class ResponsiveDrawer extends StatefulWidget {
  final List<DrawerItem> drawerItems;
  final String currentRoute;
  final Function(String route) onItemTapped;
  final Widget? header;
  final Widget? footer;
  final bool showUserProfile;
  final VoidCallback? onLogout;

  const ResponsiveDrawer({
    super.key,
    required this.drawerItems,
    required this.currentRoute,
    required this.onItemTapped,
    this.header,
    this.footer,
    this.showUserProfile = true,
    this.onLogout,
  });

  @override
  State<ResponsiveDrawer> createState() => _ResponsiveDrawerState();
}

class _ResponsiveDrawerState extends State<ResponsiveDrawer> {
  final Set<String> _expandedItems = <String>{};

  @override
  Widget build(BuildContext context) {
    if (ResponsiveLayout.isMobile(context)) {
      return _buildMobileDrawer(context);
    } else {
      return _buildDesktopDrawer(context);
    }
  }

  Widget _buildMobileDrawer(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Drawer(
      backgroundColor: colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            if (widget.header != null)
              widget.header!
            else if (widget.showUserProfile)
              _buildUserProfile(context),

            const Divider(height: 1),

            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: _buildDrawerItems(context),
              ),
            ),

            // Footer
            if (widget.footer != null) ...[
              const Divider(height: 1),
              widget.footer!,
            ],

            // Logout Button
            if (widget.onLogout != null) ...[
              const Divider(height: 1),
              _buildLogoutButton(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopDrawer(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          if (widget.header != null)
            widget.header!
          else if (widget.showUserProfile)
            _buildUserProfile(context),

          const Divider(height: 1),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: _buildDrawerItems(context),
            ),
          ),

          // Footer
          if (widget.footer != null) ...[
            const Divider(height: 1),
            widget.footer!,
          ],

          // Logout Button
          if (widget.onLogout != null) ...[
            const Divider(height: 1),
            _buildLogoutButton(context),
          ],
        ],
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: colorScheme.primary,
            child: Icon(
              Icons.person,
              color: colorScheme.onPrimary,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'john.doe@example.com',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDrawerItems(BuildContext context) {
    return widget.drawerItems.map((item) {
      final isSelected = widget.currentRoute == item.route;
      final hasSubItems = item.subItems != null && item.subItems!.isNotEmpty;

      if (hasSubItems) {
        return _buildExpandableItem(context, item);
      } else {
        return _buildDrawerItem(context, item, isSelected);
      }
    }).toList();
  }

  Widget _buildDrawerItem(BuildContext context, DrawerItem item, bool isSelected) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        leading: Icon(
          isSelected && item.selectedIcon != null ? item.selectedIcon : item.icon,
          color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
          size: 24,
        ),
        title: Text(
          item.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isSelected ? colorScheme.primary : colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        trailing: item.badgeCount != null
            ? _buildBadge(context, item.badgeCount!)
            : null,
        selected: isSelected,
        selectedTileColor: colorScheme.primaryContainer.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () {
          widget.onItemTapped(item.route);
          if (ResponsiveLayout.isMobile(context)) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  Widget _buildExpandableItem(BuildContext context, DrawerItem item) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isExpanded = _expandedItems.contains(item.route);
    final hasSelectedChild = item.subItems!.any((subItem) => widget.currentRoute == subItem.route);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              item.icon,
              color: hasSelectedChild ? colorScheme.primary : colorScheme.onSurfaceVariant,
              size: 24,
            ),
            title: Text(
              item.title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: hasSelectedChild ? colorScheme.primary : colorScheme.onSurface,
                fontWeight: hasSelectedChild ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: colorScheme.onSurfaceVariant,
            ),
            selected: hasSelectedChild,
            selectedTileColor: colorScheme.primaryContainer.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () {
              setState(() {
                if (isExpanded) {
                  _expandedItems.remove(item.route);
                } else {
                  _expandedItems.add(item.route);
                }
              });
            },
          ),
          if (isExpanded)
            ...item.subItems!.map((subItem) {
              final isSelected = widget.currentRoute == subItem.route;
              return Container(
                margin: const EdgeInsets.only(left: 16, right: 8, bottom: 2),
                child: ListTile(
                  leading: Icon(
                    isSelected && subItem.selectedIcon != null
                        ? subItem.selectedIcon
                        : subItem.icon,
                    color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  title: Text(
                    subItem.title,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  trailing: subItem.badgeCount != null
                      ? _buildBadge(context, subItem.badgeCount!)
                      : null,
                  selected: isSelected,
                  selectedTileColor: colorScheme.primaryContainer.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onTap: () {
                    widget.onItemTapped(subItem.route);
                    if (ResponsiveLayout.isMobile(context)) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildBadge(BuildContext context, int count) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.error,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        count > 99 ? '99+' : count.toString(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onError,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: widget.onLogout,
          icon: Icon(
            Icons.logout,
            color: colorScheme.error,
            size: 20,
          ),
          label: Text(
            'Logout',
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: colorScheme.error),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}