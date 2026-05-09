import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import '../widgets/workout1_content_layout.dart';

/// Workout1_SkillReps_Entry
class Workout1SkillRepsEntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1SkillRepsEntryScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: 'Start Skill Reps',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: DotLottieLoader.fromAsset(
              'assets/lotties/game.lottie',
              frameBuilder: (BuildContext context, DotLottie? lottie) {
                if (lottie != null) {
                  return Lottie.memory(lottie.animations.values.single);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Skill Reps',
            style: AppTypography.h1.copyWith(fontSize: 34, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Reinforce separation under pressure.',
            style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.4)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Three short reps. No scores. Just training.',
            style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.2)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Shared intro screen for skill reps
class Workout1SRIntroScreen extends StatelessWidget {
  final String title;
  final String body1;
  final String body2;
  final VoidCallback onStart;
  final VoidCallback onSkip;
  final VoidCallback onBack;

  const Workout1SRIntroScreen({
    required this.title,
    required this.body1,
    required this.body2,
    required this.onStart,
    required this.onSkip,
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onStart,
      onBack: onBack,
      nextButtonText: '  Start',
      showHome: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            body1,
            style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            body2,
            style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          TextButton(
            onPressed: onSkip,
            child: Text(
              'Skip Game →',
              style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3)),
            ),
          ),
        ],
      ),
    );
  }
}
