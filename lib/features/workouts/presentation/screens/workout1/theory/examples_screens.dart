import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/workout1_content_layout.dart';

/// Workout1_Examples_Intro
class Workout1ExamplesIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1ExamplesIntroScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  See Examples',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 800),
            child: Text(
              '"Stories do not arrive as stories."',
              style: AppTypography.h2.copyWith(fontSize: 26, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          FadeIn(
            delay: const Duration(milliseconds: 800),
            duration: const Duration(milliseconds: 800),
            child: Text(
              '"They arrive as conclusions."',
              style: AppTypography.h2.copyWith(
                fontSize: 26,
                fontStyle: FontStyle.italic,
                color: AppColors.ink.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// Shared example screen layout
class _ExampleScreen extends StatelessWidget {
  final String systemLine1;
  final String? systemLine2;
  final List<String> realityLines;
  final String microText;
  final String ctaText;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _ExampleScreen({
    required this.systemLine1,
    this.systemLine2,
    required this.realityLines,
    required this.microText,
    required this.ctaText,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: ctaText,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SYSTEM',
            style: AppTypography.columnHeader.copyWith(
              fontSize: 9,
              color: AppColors.ink.withOpacity(0.25),
              letterSpacing: 3.0,
            ),
          ),
          const SizedBox(height: 12),
          FadeIn(
            child: Text(
              '"$systemLine1"',
              style: AppTypography.h2.copyWith(fontSize: 22, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          if (systemLine2 != null) ...[
            const SizedBox(height: 8),
            FadeIn(
              delay: const Duration(milliseconds: 400),
              child: Text(
                '"$systemLine2"',
                style: AppTypography.h2.copyWith(fontSize: 22, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          const SizedBox(height: 32),
          Container(
            height: 1,
            width: 60,
            color: AppColors.line.withOpacity(0.3),
          ),
          const SizedBox(height: 32),
          Text(
            'REALITY',
            style: AppTypography.columnHeader.copyWith(
              fontSize: 9,
              color: const Color(0xFF10B981).withOpacity(0.5),
              letterSpacing: 3.0,
            ),
          ),
          const SizedBox(height: 12),
          for (final line in realityLines)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: FadeIn(
                delay: const Duration(milliseconds: 800),
                child: Text(
                  '"$line"',
                  style: AppTypography.p.copyWith(
                    fontSize: 16,
                    color: AppColors.ink.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          const SizedBox(height: 24),
          FadeIn(
            delay: const Duration(milliseconds: 1200),
            child: Text(
              microText,
              style: AppTypography.columnHeader.copyWith(
                fontSize: 9,
                color: AppColors.ink.withOpacity(0.2),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// Workout1_Example_Party
class Workout1ExamplePartyScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1ExamplePartyScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return _ExampleScreen(
      systemLine1: "They didn't greet you.",
      systemLine2: "Something's wrong.",
      realityLines: const ["They didn't see you."],
      microText: 'The story appeared instantly.',
      ctaText: '  Next Example',
      onNext: onNext,
      onBack: onBack,
    );
  }
}

/// Workout1_Example_Health
class Workout1ExampleHealthScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1ExampleHealthScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return _ExampleScreen(
      systemLine1: 'Something feels off.',
      systemLine2: 'What if this gets worse?',
      realityLines: const ['Stress.', 'Fatigue.', 'Posture.', 'Dehydration.'],
      microText: 'Meaning added before evidence.',
      ctaText: '  Next Example',
      onNext: onNext,
      onBack: onBack,
    );
  }
}

/// Workout1_Example_Relationship
class Workout1ExampleRelationshipScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1ExampleRelationshipScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return _ExampleScreen(
      systemLine1: "They're being short.",
      systemLine2: "They're losing interest.",
      realityLines: const ["They're tired.", "They're distracted."],
      microText: '',
      ctaText: '  Next Example',
      onNext: onNext,
      onBack: onBack,
    );
  }
}

/// Workout1_Example_PastTag
class Workout1ExamplePastTagScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1ExamplePastTagScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Continue to Evidence',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SYSTEM',
            style: AppTypography.columnHeader.copyWith(
              fontSize: 9,
              color: AppColors.ink.withOpacity(0.25),
              letterSpacing: 3.0,
            ),
          ),
          const SizedBox(height: 12),
          FadeIn(
            child: Text(
              '"You once felt anxious here."',
              style: AppTypography.h2.copyWith(fontSize: 22, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          FadeIn(
            delay: const Duration(milliseconds: 400),
            child: Text(
              '"Your system tagged the place — not the moment."',
              style: AppTypography.h2.copyWith(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: AppColors.ink.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          Container(height: 1, width: 60, color: AppColors.line.withOpacity(0.3)),
          const SizedBox(height: 32),
          Text(
            'REALITY',
            style: AppTypography.columnHeader.copyWith(
              fontSize: 9,
              color: const Color(0xFF10B981).withOpacity(0.5),
              letterSpacing: 3.0,
            ),
          ),
          const SizedBox(height: 12),
          FadeIn(
            delay: const Duration(milliseconds: 800),
            child: Text(
              '"The danger wasn\'t the location."',
              style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 6),
          FadeIn(
            delay: const Duration(milliseconds: 1000),
            child: Text(
              '"It was the internal state."',
              style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          FadeIn(
            delay: const Duration(milliseconds: 1400),
            child: Text(
              '"Tags can be updated."',
              style: AppTypography.columnHeader.copyWith(
                fontSize: 9,
                color: AppColors.ink.withOpacity(0.2),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
