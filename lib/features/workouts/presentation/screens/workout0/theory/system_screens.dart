import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SystemTitleScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SystemTitleScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.layoutGrid, size: 48, color: AppColors.ink.withOpacity(0.1)),
          const SizedBox(height: 32),
          Text(
            'The System',
            style: AppTypography.h1.copyWith(fontSize: 48, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Protective. Fast. Not your identity.',
            style: AppTypography.columnHeader.copyWith(color: AppColors.ink.withOpacity(0.35), letterSpacing: 2.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SystemReframeScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SystemReframeScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Not broken.',
            style: AppTypography.h1.copyWith(fontSize: 32, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Not weak.',
            style: AppTypography.h1.copyWith(fontSize: 32, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Not out of control.',
            style: AppTypography.h1.copyWith(fontSize: 32, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SystemDefinitionScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SystemDefinitionScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'It is a high-alert system. A loyal one.',
            style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'A hardworking one. But one that was designed to spot problems fast — not modern life.',
            style: AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.4)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
