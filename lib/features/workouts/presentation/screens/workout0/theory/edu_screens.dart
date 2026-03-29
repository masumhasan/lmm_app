import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

class EduIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const EduIntroScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      isDark: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'MUSCLE FOCUS: ATTENTION CONTROL',
            style: AppTypography.columnHeader.copyWith(color: Colors.white.withOpacity(0.5)),
          ),
          const SizedBox(height: 32),
          Text(
            'The education you never received.',
            style: AppTypography.h1.copyWith(color: Colors.white, fontSize: 32, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'You were never taught this.',
            style: AppTypography.p.copyWith(color: Colors.white.withOpacity(0.4)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class EduUntrainedScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const EduUntrainedScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You didn’t fail.',
            style: AppTypography.h1.copyWith(fontSize: 32, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'School taught you math, language, history... but not how to handle what it feels like to be human.',
            style: AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.4)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Column(
            children: ['FEAR', 'OVERTHINKING', 'PRESSURE', 'SELF-DOUBT'].asMap().entries.map((e) {
              return FadeInUp(
                delay: Duration(milliseconds: 1000 + (e.key * 800)),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.line.withOpacity(0.2)),
                  ),
                  child: Text(
                    e.value,
                    style: AppTypography.columnHeader.copyWith(fontSize: 10, letterSpacing: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
