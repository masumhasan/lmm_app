import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import '../widgets/workout1_content_layout.dart';

/// Workout1_D1_Intro — Snap Detection
class Workout1D1IntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1D1IntroScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Start',
      showHome: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PATTERN RECOGNITION + STORY SEPARATION',
            style: AppTypography.columnHeader.copyWith(
              fontSize: 8,
              color: AppColors.ink.withOpacity(0.25),
              letterSpacing: 2.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Snap Detection',
            style: AppTypography.h1.copyWith(fontSize: 30, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Stories form in fragments.',
            style: AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            "You're training the moment meaning begins.",
            style: AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
