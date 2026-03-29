import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

class ClosingIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const ClosingIntroScreen({required this.onNext, required this.onBack, super.key});

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
            '✨ Workout Complete',
            style: AppTypography.h1.copyWith(color: Colors.white, fontSize: 32),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Muscles Activated Today',
            style: AppTypography.h2.copyWith(color: Colors.white.withOpacity(0.7), fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            '“Your system isn’t the enemy.”',
            style: AppTypography.p.copyWith(color: Colors.white.withOpacity(0.4), fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ClosingMainScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const ClosingMainScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PacedText(text: 'You didn’t control your attention.', delayMs: 0),
          const SizedBox(height: 24),
          _PacedText(text: 'You saw where it moves.', delayMs: 1400),
          const SizedBox(height: 24),
          _PacedText(text: 'It was already happening—', delayMs: 2800),
          const SizedBox(height: 24),
          _PacedText(text: 'Now it’s visible.', delayMs: 4200),
        ],
      ),
    );
  }
}

class NoticeScreen extends StatelessWidget {
  final String line1;
  final String line2;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final int hold1Ms;
  final int hold2Ms;

  const NoticeScreen({
    required this.line1,
    required this.line2,
    required this.onNext,
    required this.onBack,
    this.hold1Ms = 1200,
    this.hold2Ms = 1400,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      isDark: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 400),
            child: Text(
              '“$line1”',
              style: AppTypography.h2.copyWith(color: Colors.white, fontSize: 24, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          FadeIn(
            delay: Duration(milliseconds: 600 + hold1Ms),
            duration: const Duration(milliseconds: 400),
            child: Text(
              '“$line2”',
              style: AppTypography.h2.copyWith(color: Colors.white.withOpacity(0.7), fontSize: 24, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _PacedText extends StatelessWidget {
  final String text;
  final int delayMs;
  const _PacedText({required this.text, required this.delayMs});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: delayMs),
      duration: const Duration(milliseconds: 800),
      child: Text(
        text,
        style: AppTypography.h2.copyWith(fontSize: 22, height: 1.4),
        textAlign: TextAlign.center,
      ),
    );
  }
}
