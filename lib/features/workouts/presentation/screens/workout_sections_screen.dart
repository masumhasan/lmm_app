import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/shared/widgets/premium_card.dart';
import 'package:lmm_app/features/workouts/domain/models/workout.dart';
import 'package:go_router/go_router.dart';

class WorkoutSectionsScreen extends StatelessWidget {
  final String workoutId;
  const WorkoutSectionsScreen({required this.workoutId, super.key});

  @override
  Widget build(BuildContext context) {
    // Finding mock workout (assume id 0 for demo)
    final workout = Workout.mockList.firstWhere(
      (w) => w.id.toString() == workoutId,
      orElse: () => Workout.mockList.first,
    );

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        leadingWidth: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(LucideIcons.x, color: AppColors.ink.withOpacity(0.3), size: 24),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'NAVIGATION',
              style: AppTypography.columnHeader.copyWith(
                fontSize: 8,
                color: AppColors.ink.withOpacity(0.2),
                letterSpacing: 2.5,
              ),
            ),
            Text(
              'Workout Sections',
              style: AppTypography.h1.copyWith(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _IntrolHeader(workout: workout),
            const SizedBox(height: 32),
            Text(
              'STRUCTURE',
              style: AppTypography.columnHeader.copyWith(
                color: AppColors.ink.withOpacity(0.2),
                letterSpacing: 3.5,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              itemCount: workout.sections.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final section = workout.sections[index];
                return _SectionTile(section: section);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _IntrolHeader extends StatelessWidget {
  final Workout workout;
  const _IntrolHeader({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'INTRO',
          style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.15)),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2135),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workout.title,
                style: AppTypography.h1.copyWith(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                workout.description,
                style: AppTypography.p.copyWith(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTile extends StatefulWidget {
  final WorkoutSection section;
  const _SectionTile({required this.section});

  @override
  State<_SectionTile> createState() => _SectionTileState();
}

class _SectionTileState extends State<_SectionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasSubSections = widget.section.subSections != null;

    return Column(
      children: [
        PremiumCard(
          onTap: () {
            if (hasSubSections) {
              setState(() => isExpanded = !isExpanded);
            } else {
              context.push('/workouts/0/play?section=${widget.section.id}');
            }
          },
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          borderRadius: 16,
          child: Row(
            children: [
              _StatusIcon(section: widget.section),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.section.title,
                          style: AppTypography.columnHeader.copyWith(
                            fontSize: 13,
                            color: AppColors.ink,
                          ),
                        ),
                        if (widget.section.duration.isNotEmpty)
                          Text(
                            '⌚ ${widget.section.duration}',
                            style: AppTypography.columnHeader.copyWith(
                              fontSize: 9,
                              color: AppColors.ink.withOpacity(0.15),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.section.description,
                      style: AppTypography.p.copyWith(
                        fontSize: 12,
                        color: AppColors.ink.withOpacity(0.35),
                      ),
                    ),
                  ],
                ),
              ),
              if (!hasSubSections)
                Icon(LucideIcons.chevronRight, size: 14, color: AppColors.ink.withOpacity(0.1))
              else
                Icon(isExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown, size: 14, color: AppColors.ink.withOpacity(0.2)),
            ],
          ),
        ),
        if (hasSubSections && isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              children: widget.section.subSections!.map((s) => _SubSectionTile(section: s)).toList(),
            ),
          ),
      ],
    );
  }
}

class _SubSectionTile extends StatelessWidget {
  final WorkoutSection section;
  const _SubSectionTile({required this.section});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/workouts/0/play?section=${section.id}'),
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.line.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.check, size: 10, color: Color(0xFF10B981)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.title,
                    style: AppTypography.columnHeader.copyWith(fontSize: 11, color: AppColors.ink),
                  ),
                  Text(
                    section.description,
                    style: AppTypography.p.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.25)),
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight, size: 12, color: AppColors.ink.withOpacity(0.1)),
          ],
        ),
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final WorkoutSection section;
  const _StatusIcon({required this.section});

  @override
  Widget build(BuildContext context) {
    if (section.isCompleted) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981).withOpacity(0.08),
          shape: BoxShape.circle,
        ),
        child: const Icon(LucideIcons.check, size: 16, color: Color(0xFF10B981)),
      );
    }
    if (section.isLocked) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.ink.withOpacity(0.03),
          shape: BoxShape.circle,
        ),
        child: Icon(LucideIcons.lock, size: 16, color: AppColors.ink.withOpacity(0.1)),
      );
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.ink.withOpacity(0.03),
        shape: BoxShape.circle,
      ),
      child: Text(
        '1', // Fallback for demo
        style: AppTypography.mono.copyWith(fontSize: 12, color: AppColors.ink.withOpacity(0.2)),
      ),
    );
  }
}
