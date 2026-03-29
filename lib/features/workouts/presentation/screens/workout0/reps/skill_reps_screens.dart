import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SkillRepsEntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SkillRepsEntryScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '🟢 Start Skill Reps',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.gamepad2, size: 48, color: AppColors.accent.withOpacity(0.2)),
          const SizedBox(height: 32),
          Text(
            'Train Your Attention',
            style: AppTypography.h1.copyWith(fontSize: 34, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'These games reveal how attention gets captured — and how it changes.',
            style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.4)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            '“You’re not calming anything here. You’re training attention control.”',
            style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.2)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SRIntroScreen extends StatelessWidget {
  final String title;
  final String subtext;
  final String instruction;
  final VoidCallback onStart;
  final VoidCallback onSkip;
  final VoidCallback onBack;

  const SRIntroScreen({
    required this.title,
    required this.subtext,
    required this.instruction,
    required this.onStart,
    required this.onSkip,
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onStart,
      onBack: onBack,
      nextButtonText: '▶ Start',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeInDown(
            child: Text(
              title,
              style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          FadeInDown(
            delay: const Duration(milliseconds: 400),
            child: Text(
              subtext,
              style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.4)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          FadeIn(
            delay: const Duration(milliseconds: 800),
            child: Text(
              instruction,
              style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.2)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          TextButton(
            onPressed: onSkip,
            child: Text(
              'Skip →',
              style: AppTypography.columnHeader.copyWith(
                fontSize: 10,
                color: AppColors.ink.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutCompleteScreen extends StatelessWidget {
  final VoidCallback onHome;
  const WorkoutCompleteScreen({required this.onHome, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Background subtle texture or gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearSync.subtleRadial(AppColors.accent.withOpacity(0.03)),
              ),
            ),
          ),
          
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Column(
                      children: [
                        Text(
                          'WORKOUT 0',
                          style: AppTypography.columnHeader.copyWith(
                            fontSize: 10,
                            letterSpacing: 4.0,
                            color: AppColors.ink.withOpacity(0.25),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Training Complete',
                          style: AppTypography.h1.copyWith(
                            fontSize: 42,
                            fontStyle: FontStyle.italic,
                            height: 1.1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '“You trained attention under pressure.”',
                          style: AppTypography.p.copyWith(
                            fontSize: 15,
                            color: AppColors.ink.withOpacity(0.4),
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                  
                  // Primary Action
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: _CompletionAction(
                      label: 'CONTINUE TRAINING',
                      subLabel: 'Workout 1: Story Separation',
                      icon: LucideIcons.arrowRight,
                      isPrimary: true,
                      onTap: onHome,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Secondary Actions
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: _CompletionAction(
                      label: 'TOOLS HUB',
                      icon: LucideIcons.layoutGrid,
                      onTap: onHome,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    delay: const Duration(milliseconds: 700),
                    child: _CompletionAction(
                      label: 'TALK IT THROUGH',
                      icon: LucideIcons.messageSquare,
                      isBadge: true,
                      onTap: onHome,
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // Flat exit
                  FadeIn(
                    delay: const Duration(milliseconds: 1200),
                    child: TextButton(
                      onPressed: onHome,
                      child: Text(
                        'RETURN TO DASHBOARD',
                        style: AppTypography.columnHeader.copyWith(
                          fontSize: 9,
                          letterSpacing: 2.0,
                          color: AppColors.ink.withOpacity(0.35),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletionAction extends StatelessWidget {
  final String label;
  final String? subLabel;
  final IconData icon;
  final bool isPrimary;
  final bool isBadge;
  final VoidCallback onTap;

  const _CompletionAction({
    required this.label,
    this.subLabel,
    required this.icon,
    this.isPrimary = false,
    this.isBadge = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.accent : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPrimary ? AppColors.accent : AppColors.line.withOpacity(0.3),
          ),
          boxShadow: isPrimary ? [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ] : [],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: AppTypography.columnHeader.copyWith(
                          fontSize: 11,
                          letterSpacing: 1.2,
                          color: isPrimary ? Colors.white : AppColors.ink,
                        ),
                      ),
                      if (isBadge) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'LOCKED',
                            style: AppTypography.mono.copyWith(fontSize: 7, color: AppColors.accent),
                          ),
                        ),
                      ]
                    ],
                  ),
                  if (subLabel != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subLabel!,
                      style: AppTypography.p.copyWith(
                        fontSize: 12,
                        color: isPrimary ? Colors.white.withOpacity(0.6) : AppColors.ink.withOpacity(0.4),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              icon,
              size: 16,
              color: isPrimary ? Colors.white : AppColors.ink.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}

class LinearSync {
  static RadialGradient subtleRadial(Color color) {
    return RadialGradient(
      center: const Alignment(0, -0.2),
      radius: 1.2,
      colors: [color, Colors.transparent],
    );
  }
}
