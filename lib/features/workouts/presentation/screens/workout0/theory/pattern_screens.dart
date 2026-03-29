import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PatternIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const PatternIntroScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '▶ Next',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Understanding the Pattern',
            style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.2), letterSpacing: 2),
          ),
          const SizedBox(height: 32),
          Text(
            'Your system often misreads harmless moments as danger.',
            style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            '“Let’s look at real life.”',
            style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.4)),
          ),
        ],
      ),
    );
  }
}

class PatternExample1Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const PatternExample1Screen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '▶ Next Example',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.smartphone, size: 48, color: AppColors.ink.withOpacity(0.1)),
          const SizedBox(height: 48),
          _PatternLine(text: '“Your phone lights up.”', delay: 0),
          _PatternLine(text: '“It’s not the person you hoped it was.”', delay: 1200),
          const SizedBox(height: 32),
          _PatternLine(text: 'System: “Something’s changed. I should check.”', delay: 2400, color: AppColors.ink.withOpacity(0.35)),
          const SizedBox(height: 32),
          Divider(color: AppColors.line.withOpacity(0.1)),
          const SizedBox(height: 32),
          _PatternLine(text: 'Truth: “They’re busy. Nothing changed. The system guessed danger.”', delay: 3600),
          const SizedBox(height: 24),
          _PatternLine(text: '“A guess can feel real — without being evidence.”', delay: 4800, isSmall: true),
        ],
      ),
    );
  }
}

class PatternExample2Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const PatternExample2Screen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '▶ Next Example',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.calendar, size: 48, color: AppColors.ink.withOpacity(0.1)),
          const SizedBox(height: 48),
          _PatternLine(text: '“Your manager says: ‘Can we talk tomorrow?’”', delay: 0),
          const SizedBox(height: 32),
          _PatternLine(text: 'System: “What did I do wrong?”', delay: 1200, color: AppColors.ink.withOpacity(0.35)),
          const SizedBox(height: 32),
          Divider(color: AppColors.line.withOpacity(0.1)),
          const SizedBox(height: 32),
          _PatternLine(text: 'Truth: “It could be a new project. It could be nothing. The system guessed danger.”', delay: 2400),
        ],
      ),
    );
  }
}

class PatternExample3Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const PatternExample3Screen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '▶ Next Example',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.users, size: 48, color: AppColors.ink.withOpacity(0.1)),
          const SizedBox(height: 48),
          _PatternLine(text: '“Your child misbehaves.”', delay: 0),
          const SizedBox(height: 32),
          _PatternLine(text: 'System: “You’re failing as a parent.”', delay: 1200, color: AppColors.ink.withOpacity(0.35)),
          const SizedBox(height: 32),
          Divider(color: AppColors.line.withOpacity(0.1)),
          const SizedBox(height: 32),
          _PatternLine(text: 'Truth: “They’re having a moment. The system guessed danger.”', delay: 2400),
        ],
      ),
    );
  }
}

class PatternExample4Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const PatternExample4Screen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '▶ Why This Happens',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(LucideIcons.train, size: 32, color: AppColors.ink.withOpacity(0.1)),
              const SizedBox(width: 8),
              Icon(LucideIcons.shoppingBag, size: 32, color: AppColors.ink.withOpacity(0.1)),
              const SizedBox(width: 8),
              Icon(LucideIcons.utensils, size: 32, color: AppColors.ink.withOpacity(0.1)),
            ],
          ),
          const SizedBox(height: 48),
          _PatternLine(text: '“You felt an alarm surge once in a public place.”', delay: 0),
          _PatternLine(text: '“Your system stored that moment.”', delay: 1200),
          const SizedBox(height: 16),
          _PatternLine(text: 'System: “Never go there again.”', delay: 2400, color: AppColors.ink.withOpacity(0.35)),
          const SizedBox(height: 32),
          Divider(color: AppColors.line.withOpacity(0.1)),
          const SizedBox(height: 32),
          _PatternLine(text: 'Truth: “The place wasn’t dangerous. Your internal state created a false association.”', delay: 3600),
          const SizedBox(height: 16),
          _PatternLine(text: '“Tags can be retrained.”', delay: 4800, isSmall: true, color: AppColors.accent),
        ],
      ),
    );
  }
}

class _PatternLine extends StatelessWidget {
  final String text;
  final int delay;
  final Color? color;
  final bool isSmall;

  const _PatternLine({
    required this.text,
    required this.delay,
    this.color,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      duration: const Duration(milliseconds: 800),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          style: isSmall 
            ? AppTypography.columnHeader.copyWith(fontSize: 9, color: color ?? AppColors.ink.withOpacity(0.3))
            : AppTypography.h2.copyWith(fontSize: 18, color: color ?? AppColors.ink, height: 1.5),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
