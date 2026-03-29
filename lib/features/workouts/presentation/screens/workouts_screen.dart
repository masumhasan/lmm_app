import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/shared/widgets/premium_card.dart';
import 'package:lmm_app/features/workouts/domain/models/workout.dart';
import 'package:go_router/go_router.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workouts = Workout.mockList;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(),
            const SizedBox(height: 32),
            _SystemStatusRow(),
            const SizedBox(height: 16),
            Text(
              'Training Modules'.toUpperCase(),
              style: AppTypography.columnHeader.copyWith(
                color: AppColors.ink.withOpacity(0.35),
                letterSpacing: 3.5,
              ),
            ),
            const SizedBox(height: 24),
            ListView.separated(
              itemCount: workouts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final workout = workouts[index];
                return _WorkoutListTile(workout: workout);
              },
            ),
            const SizedBox(height: 24),
            _QuickResetCard(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LearnMyMind',
          style: AppTypography.h1.copyWith(
            fontSize: 28,
            fontStyle: FontStyle.normal,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          'COGNITIVE LABORATORY',
          style: AppTypography.columnHeader.copyWith(
            fontSize: 8,
            color: AppColors.ink.withOpacity(0.3),
            letterSpacing: 2.5,
          ),
        ),
      ],
    );
  }
}

class _SystemStatusRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(LucideIcons.zap, size: 12, color: AppColors.accent),
        const SizedBox(width: 8),
        Text(
          'SYSTEM ACTIVE',
          style: AppTypography.columnHeader.copyWith(
            fontSize: 9,
            color: AppColors.accent.withOpacity(0.8),
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

class _WorkoutListTile extends StatelessWidget {
  final Workout workout;

  const _WorkoutListTile({required this.workout});

  @override
  Widget build(BuildContext context) {
    final statusColor = workout.status == WorkoutStatus.inProgress 
      ? const Color(0xFFF59E0B) 
      : AppColors.ink.withOpacity(0.15);
    final statusText = workout.status == WorkoutStatus.inProgress ? 'IN\nPROGRESS' : 'NOT\nSTARTED';

    return PremiumCard(
      onTap: () => context.push('/workouts/${workout.id}'),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      borderRadius: 16,
      child: Row(
        children: [
          Text(
            '0${workout.id}',
            style: AppTypography.mono.copyWith(
              fontSize: 10,
              color: AppColors.ink.withOpacity(0.08),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.title.toUpperCase(),
                  style: AppTypography.columnHeader.copyWith(
                    fontSize: 13,
                    letterSpacing: 1.0,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  workout.description,
                  style: AppTypography.p.copyWith(
                    fontSize: 12,
                    color: AppColors.ink.withOpacity(0.4),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'COMPLEXITY',
                style: AppTypography.columnHeader.copyWith(
                  fontSize: 7,
                  color: AppColors.ink.withOpacity(0.2),
                ),
              ),
              Text(
                '${workout.difficulty}/10',
                style: AppTypography.mono.copyWith(
                  fontSize: 10,
                  color: AppColors.ink.withOpacity(0.4),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                statusText,
                style: AppTypography.columnHeader.copyWith(
                  fontSize: 8,
                  color: statusColor,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
          const SizedBox(width: 16),
          Icon(
            LucideIcons.chevronRight,
            size: 16,
            color: AppColors.ink.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}

class _QuickResetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2135),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quick Reset',
                style: AppTypography.h2.copyWith(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 28,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(LucideIcons.play, color: Colors.white, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '3-minute cognitive recalibration',
            style: AppTypography.p.copyWith(
              color: Colors.white.withOpacity(0.3),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _Tag(label: 'FOCUS'),
              _Tag(label: 'CLARITY'),
              _Tag(label: 'PEACE'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Text(
        label,
        style: AppTypography.columnHeader.copyWith(
          fontSize: 8,
          color: Colors.white.withOpacity(0.5),
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
