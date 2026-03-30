import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/shared/widgets/premium_card.dart';
import 'package:go_router/go_router.dart';

class ToolsHubScreen extends StatelessWidget {
  const ToolsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tools Hub',
              style: AppTypography.h1.copyWith(fontSize: 34),
            ),
            const SizedBox(height: 8),
            Text(
              'All modules and utilities in one place.',
              style: AppTypography.p.copyWith(
                color: AppColors.ink.withOpacity(0.4),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 48),
            
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
              children: [
                _ToolCard(
                  icon: LucideIcons.activity,
                  label: 'Training Floor',
                  onTap: () => context.go('/workouts'),
                ),
                _ToolCard(
                  icon: LucideIcons.user,
                  label: 'Profile',
                  onTap: () => context.go('/hub/profile'),
                ),
                _ToolCard(
                  icon: LucideIcons.messageSquare,
                  label: 'AI Coach',
                  onTap: () => context.go('/ai-coach'),
                ),
                _ToolCard(
                  icon: LucideIcons.wind,
                  label: 'Drift',
                  onTap: () => context.go('/drift'),
                ),
                _ToolCard(
                  icon: LucideIcons.zap,
                  label: 'Return To Now',
                  onTap: () => context.go('/now'),
                ),
                _ToolCard(
                  icon: LucideIcons.plus,
                  label: 'More...',
                  onTap: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ToolCard({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: PremiumCard(
        padding: const EdgeInsets.all(24),
        borderRadius: 24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.ink.withOpacity(0.03),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: onTap == null ? AppColors.ink.withOpacity(0.1) : AppColors.ink,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              label.toUpperCase(),
              style: AppTypography.columnHeader.copyWith(
                fontSize: 10,
                letterSpacing: 1.0,
                color: onTap == null ? AppColors.ink.withOpacity(0.15) : AppColors.ink,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
