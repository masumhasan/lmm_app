import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/shared/widgets/theory_card.dart';

class SystemDetailedDefinitionScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SystemDetailedDefinitionScreen({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  State<SystemDetailedDefinitionScreen> createState() =>
      _SystemDetailedDefinitionScreenState();
}

class _SystemDetailedDefinitionScreenState
    extends State<SystemDetailedDefinitionScreen> {
  bool showMicroLine = false;
  bool showCTA = false;

  @override
  void initState() {
    super.initState();
    // Simulate voiceover timing
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) setState(() => showMicroLine = true);
    });
    Future.delayed(const Duration(milliseconds: 4400), () {
      if (mounted) setState(() => showCTA = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: widget.onNext,
      onBack: widget.onBack,
      showNextButton: showCTA,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Shield Symbol
          FadeInDown(
            duration: const Duration(milliseconds: 1000),
            child: Icon(
              LucideIcons.shield,
              size: 64,
              color: AppColors.accent.withOpacity(0.1),
            ),
          ),
          const SizedBox(height: 48),
          Text(
            'It is a high-alert system.\nA loyal one.\nA hardworking one.\nBut one that was designed to spot problems fast, not modern life.',
            style: AppTypography.h2.copyWith(fontSize: 22, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          if (showMicroLine)
            FadeIn(
              duration: const Duration(milliseconds: 600),
              child: Text(
                'Protection ≠ Truth',
                style: AppTypography.columnHeader.copyWith(
                  fontSize: 10,
                  color: AppColors.accent,
                  letterSpacing: 2,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SystemContextScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SystemContextScreen({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 750),
                  child: Icon(
                    LucideIcons.alertTriangle,
                    size: 40,
                    color: Colors.red.withOpacity(0.1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: FadeInRight(
                    duration: const Duration(milliseconds: 1500),
                    child: Icon(
                      LucideIcons.layers,
                      size: 40,
                      color: AppColors.accent.withOpacity(0.1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Text(
            'Back then, the system scanned for lions and danger.',
            style: AppTypography.h2.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Now?\nIt scans your phone notifications, your conversations, your to-do list, your relationships, your image, your past, your future… everything.',
            style: AppTypography.p.copyWith(
              fontSize: 16,
              color: AppColors.ink.withOpacity(0.5),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SystemSymptomsScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SystemSymptomsScreen({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final symptoms = [
      'Racing thoughts',
      'Tightness',
      'A sudden surge',
      'Negative predictions',
      'What ifs',
      'Overthinking',
    ];

    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Your system is not trying to hurt you.\nIt runs on high sensitivity.\nIt is not you.',
            style: AppTypography.h2.copyWith(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          ...List.generate(symptoms.length, (index) {
            return FadeInUp(
              delay: Duration(milliseconds: 1000 + (index * 400)),
              child: TheoryCard(
                child: Text(
                  symptoms[index],
                  style: AppTypography.p.copyWith(
                    fontSize: 16,
                    color: AppColors.ink.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class SystemShiftScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SystemShiftScreen({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: ZoomOut(
        duration: const Duration(seconds: 4),
        from: 1.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You’ve lived inside those alarms for years.',
              style: AppTypography.h2.copyWith(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Now, you’ll step outside of them.',
              style: AppTypography.h1.copyWith(
                fontSize: 28,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
