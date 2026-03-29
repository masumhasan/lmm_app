import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavbar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: const Border(
            top: BorderSide(color: AppColors.line, width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(
                  icon: LucideIcons.home,
                  label: 'Home',
                  isSelected: navigationShell.currentIndex == 0,
                  onTap: () => _onTap(context, 0),
                ),
                _NavBarItem(
                  icon: LucideIcons.brain,
                  label: 'Workouts',
                  isSelected: navigationShell.currentIndex == 1,
                  onTap: () => _onTap(context, 1),
                ),
                _NavBarItem(
                  icon: LucideIcons.wind,
                  label: 'Drift',
                  isSelected: navigationShell.currentIndex == 2,
                  onTap: () => _onTap(context, 2),
                ),
                _NavBarItem(
                  icon: LucideIcons.zap,
                  label: 'Now',
                  isSelected: navigationShell.currentIndex == 3,
                  onTap: () => _onTap(context, 3),
                ),
                _NavBarItem(
                  icon: LucideIcons.user,
                  label: 'Profile',
                  isSelected: navigationShell.currentIndex == 4,
                  onTap: () => _onTap(context, 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.accent : AppColors.ink.withOpacity(0.3),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.accent : AppColors.ink.withOpacity(0.3),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
