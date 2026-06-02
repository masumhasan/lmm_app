import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/shared/widgets/premium_card.dart';
import 'package:lmm_app/shared/widgets/app_button.dart';
import 'package:lmm_app/features/auth/domain/models/user.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = User.mock(); // Mocking user for now
    final state = UserState.mock(); // Mocking state for now

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,'.toUpperCase(),
                  style: AppTypography.columnHeader.copyWith(
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.username,
                  style: AppTypography.h1,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Daily Goal Card
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Badge(
                    label: Text('NEW TRAINING FLOOR'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Daily Goal',
                    style: AppTypography.h2.copyWith(color: AppColors.surface, fontSize: 32),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'COMPLETE 1 WORKOUT AND 1 DRIFT SESSION',
                    style: AppTypography.columnHeader.copyWith(
                      color: AppColors.surface.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: 0.33,
                      minHeight: 4,
                      backgroundColor: AppColors.surface.withOpacity(0.1),
                      valueColor: const AlwaysStoppedAnimation(AppColors.surface),
                    ),
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    text: 'Continue Training',
                    icon: LucideIcons.playCircle,
                    type: AppButtonType.secondary,
                    onPressed: () => context.go('/workouts'),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'WORKOUT 0: ATTENTION CONTROL IS READY',
                      style: AppTypography.columnHeader.copyWith(
                        color: AppColors.surface.withOpacity(0.3),
                        fontSize: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () => context.go('/now'),
              child: PremiumCard(
                padding: const EdgeInsets.all(24),
                borderRadius: 32,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(LucideIcons.zap, color: AppColors.accent, size: 24),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Return to Now'.toUpperCase(),
                            style: AppTypography.columnHeader.copyWith(letterSpacing: 1.0),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Re-orient attention instantly.',
                            style: AppTypography.p.copyWith(
                              fontSize: 14, 
                              color: AppColors.ink.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(LucideIcons.chevronRight, size: 20, color: AppColors.ink.withOpacity(0.1)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),

            // Quick Re-entry (Micro Moments)
            Text(
              'QUICK RE-ENTRY',
              style: AppTypography.columnHeader,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => context.push('/hub/micro-moments'),
              child: PremiumCard(
                padding: const EdgeInsets.all(24),
                borderRadius: 32,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(LucideIcons.zap, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MICRO MOMENTS',
                            style: AppTypography.columnHeader.copyWith(letterSpacing: 1.0),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Recognize it while it’s happening.',
                            style: AppTypography.p.copyWith(
                              fontSize: 14, 
                              color: AppColors.ink.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Noticed Earlier Card
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Noticed Earlier',
                    style: AppTypography.h4.copyWith(
                      color: AppColors.surface.withOpacity(0.6),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'You may be starting to notice small things sooner.',
                    style: AppTypography.p.copyWith(
                      color: AppColors.surface,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    text: 'View Training Log',
                    type: AppButtonType.secondary,
                    onPressed: () => context.push('/hub/muscle-dashboard'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Quick Stats
            Text(
              'QUICK STATS',
              style: AppTypography.columnHeader,
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _StatCard(
                  label: 'TOTAL REPS',
                  value: '1,240',
                ),
                _StatCard(
                  label: 'STREAK',
                  value: '${state.streakDays} DAYS',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: const EdgeInsets.all(24),
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTypography.columnHeader,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTypography.mono.copyWith(
              fontSize: 24,
              color: AppColors.ink,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final Widget label;
  const Badge({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: DefaultTextStyle(
        style: AppTypography.columnHeader.copyWith(
          fontSize: 8,
          color: AppColors.accent,
          fontWeight: FontWeight.bold,
        ),
        child: label,
      ),
    );
  }
}
