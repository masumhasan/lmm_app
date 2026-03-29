import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

class ScienceTwoSystemsScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const ScienceTwoSystemsScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'What’s Happening Inside You',
            style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Muscle Focus: Attention Control',
            style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.accent, letterSpacing: 2.5),
          ),
          const SizedBox(height: 48),
          
          _SystemCard(
            title: 'The Alarm System',
            content: 'Fast. Emotional. Protective. Reacts before checking.',
            color: Colors.red.withOpacity(0.05),
            delay: 400,
          ),
          const SizedBox(height: 16),
          _SystemCard(
            title: 'The Clarity System',
            content: 'Calm. Observing. Practical. Checks what’s actually happening.',
            color: Colors.blue.withOpacity(0.05),
            delay: 1200,
          ),
          const SizedBox(height: 48),
          FadeIn(
            delay: const Duration(milliseconds: 2400),
            child: Text(
              '“Only one system can lead at a time.”',
              style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.4)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SystemCard extends StatelessWidget {
  final String title;
  final String content;
  final Color color;
  final int delay;

  const _SystemCard({
    required this.title,
    required this.content,
    required this.color,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.line.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.5)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ScienceShiftScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const ScienceShiftScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      isLast: true, // Shows "Practice" instead of "Next" or similar
      nextButtonText: '▶ Practice',
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'When you slow down…\n\nWhen you notice a thought…\n\nYour system can shift from alarm → toward clarity.',
            style: AppTypography.h2.copyWith(fontSize: 22, height: 1.6),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Text(
            '“This isn’t positive thinking.”',
            style: AppTypography.h1.copyWith(fontSize: 24, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),
          Text(
            '“This is how repetition builds steadiness.”',
            style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.4)),
          ),
        ],
      ),
    );
  }
}
