import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';

class PatternExample1Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const PatternExample1Screen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Next Example',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 80,
            child: DotLottieLoader.fromAsset(
              'assets/lotties/Workout0_Patterns_Example1.lottie',
              frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(
                    dotlottie.animations.values.single,
                    fit: BoxFit.contain,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
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
