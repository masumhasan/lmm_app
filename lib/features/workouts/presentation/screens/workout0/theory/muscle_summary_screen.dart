import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:animate_do/animate_do.dart';

class MuscleSummaryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const MuscleSummaryScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Muscles Activated',
                style: AppTypography.h1.copyWith(fontSize: 34, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 48),
          _MuscleRow(label: 'Attention Control', isActivated: true),
          _MuscleRow(label: 'Urgency Resistance', isActivated: true),
          _MuscleRow(label: 'Completion Tolerance', isActivated: true),
          const SizedBox(height: 48),
          Center(
            child: Text(
              '“Repetition builds automatic strength.”',
              style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.4)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _MuscleRow extends StatelessWidget {
  final String label;
  final bool isActivated;
  const _MuscleRow({required this.label, required this.isActivated});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTypography.columnHeader.copyWith(fontSize: 12, color: AppColors.ink, letterSpacing: 1.0),
          ),
          if (isActivated)
            Text(
              'ACTIVATED',
              style: AppTypography.mono.copyWith(fontSize: 9, color: const Color(0xFF10B981), fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
