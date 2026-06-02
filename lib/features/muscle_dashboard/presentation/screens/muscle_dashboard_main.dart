import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:go_router/go_router.dart';

class MuscleDashboardMain extends StatelessWidget {
  const MuscleDashboardMain({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for MVP as per DATA STRUCTURE (MVP) in MUSCLE DASHBOARD.txt
    final muscles = [
      {'id': 'attention_control', 'name': 'Attention Control', 'sessions': [0, 4], 'reps': 3},
      {'id': 'urgency_resistance', 'name': 'Urgency Resistance', 'sessions': [0], 'reps': 1},
      {'id': 'completion_tolerance', 'name': 'Completion Tolerance', 'sessions': [0], 'reps': 1},
      {'id': 'pattern_recognition', 'name': 'Pattern Recognition', 'sessions': [], 'reps': 0},
      {'id': 'story_separation', 'name': 'Story Separation', 'sessions': [], 'reps': 0},
      {'id': 'loop_disruption', 'name': 'Loop Disruption', 'sessions': [], 'reps': 0},
      {'id': 'escalation_awareness', 'name': 'Escalation Awareness', 'sessions': [], 'reps': 0},
      {'id': 'sensation_separation', 'name': 'Sensation Separation', 'sessions': [], 'reps': 0},
      {'id': 'non_reactivity', 'name': 'Non-Reactivity', 'sessions': [], 'reps': 0},
      {'id': 'cognitive_distance', 'name': 'Cognitive Distance', 'sessions': [], 'reps': 0},
    ];

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cognitive Muscles',
                        style: AppTypography.h1.copyWith(fontSize: 34),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Repetition builds automatic strength.',
                        style: AppTypography.p.copyWith(
                          color: AppColors.ink.withOpacity(0.4),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.arrowLeft, 
                             size: 16, 
                             color: AppColors.ink.withOpacity(0.3)),
                        const SizedBox(width: 4),
                        Text(
                          'BACK',
                          style: AppTypography.columnHeader.copyWith(
                            fontSize: 10,
                            color: AppColors.ink.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: muscles.length,
              separatorBuilder: (context, index) => Divider(
                color: AppColors.ink.withOpacity(0.05),
                height: 48,
              ),
              itemBuilder: (context, index) {
                final muscle = muscles[index];
                final sessions = List<int>.from(muscle['sessions'] as List);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            muscle['name'] as String,
                            style: AppTypography.h2.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Sessions Trained:',
                            style: AppTypography.columnHeader.copyWith(
                              fontSize: 10,
                              color: AppColors.ink.withOpacity(0.4),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            sessions.isEmpty ? 'None' : sessions.map((s) => 'Session $s').join(', '),
                            style: AppTypography.p.copyWith(
                              fontSize: 14,
                              color: AppColors.ink.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      muscle['reps'].toString(),
                      style: AppTypography.h1.copyWith(
                        fontSize: 64,
                        color: AppColors.ink.withOpacity(0.1),
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
