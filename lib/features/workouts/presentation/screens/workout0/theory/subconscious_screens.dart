import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

class SubconsciousTitleScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SubconsciousTitleScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeInDown(
            child: Text(
              'The Training System\nHow Repetition Builds Muscle',
              style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Muscle Focus: Attention Control',
            style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.accent, letterSpacing: 2),
          ),
          const SizedBox(height: 32),
          FadeInUp(
            delay: const Duration(milliseconds: 1000),
            child: Text(
              '“It learns by repetition.”',
              style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.4)),
            ),
          ),
        ],
      ),
    );
  }
}

class IcebergModelScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const IcebergModelScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Visual Iceberg
          SizedBox(
            height: 300,
            width: 250,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Under water bg
                Positioned(
                  top: 80,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.accent.withOpacity(0.01), AppColors.accent.withOpacity(0.08)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(120),
                    ),
                  ),
                ),
                // Iceberg Top
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ClipPath(
                    clipper: IcebergClipper(),
                    child: Container(
                      height: 120,
                      width: 140,
                      color: AppColors.ink.withOpacity(0.1),
                      child: Center(
                        child: Text(
                          'Thoughts',
                          style: AppTypography.columnHeader.copyWith(fontSize: 7, color: AppColors.ink),
                        ),
                      ),
                    ),
                  ),
                ),
                // Water Line
                Positioned(
                  top: 80,
                  left: 10,
                  right: 10,
                  child: Container(height: 1, color: AppColors.ink.withOpacity(0.1)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Text(
            'Imagine your mind as an iceberg.',
            style: AppTypography.h2.copyWith(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'The tiny part at the top thoughts is what you’re aware of.',
            style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.4)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class IcebergContentsScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const IcebergContentsScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    final contents = [
      'Habits',
      'Reactions',
      'Emotional memory',
      'Protective beliefs',
      'Body responses',
    ];

    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        children: [
          const SizedBox(height: 24),
          FadeInDown(
            child: Text(
              'Underneath is everything else.',
              style: AppTypography.h1.copyWith(
                fontSize: 28,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          ...List.generate(contents.length, (i) {
            return FadeInUp(
              delay: Duration(milliseconds: 200 + (i * 100)),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.line.withOpacity(0.4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Text(
                  contents[i],
                  style: AppTypography.columnHeader.copyWith(
                    fontSize: 14,
                    color: AppColors.ink.withOpacity(0.7),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class IcebergClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class SubconsciousControlScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SubconsciousControlScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
             'This training system runs most of your day automatically, without asking.',
            style: AppTypography.h2.copyWith(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            'Mostly automatic',
            style: AppTypography.h1.copyWith(fontSize: 32, fontStyle: FontStyle.italic, color: AppColors.ink),
          ),
          const SizedBox(height: 48),
          Text(
            '“That’s why change can feel hard, even when you want it.”',
            style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.35)),
          ),
        ],
      ),
    );
  }
}

class SubconsciousRuleScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SubconsciousRuleScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Your training system doesn’t follow what is true.\nIt follows what is repeated.',
            style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            'Not because it’s real, but because it’s familiar.',
            style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SubconsciousOldScriptsScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SubconsciousOldScriptsScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    final scripts = [
      '“I’m not enough.”',
      '“I can’t handle this.”',
      '“It’s happening again.”',
      '“What if I lose control?”',
    ];

    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(scripts.length, (i) {
            return FadeInUp(
              delay: Duration(milliseconds: i * 600),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.line.withOpacity(0.12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.015),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Text(
                  scripts[i],
                  style: AppTypography.p.copyWith(
                    fontSize: 18, 
                    color: AppColors.ink.withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            );
          }),
          const SizedBox(height: 48),
          Text(
            'Your training system accepted these as instructions.',
            style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SubconsciousResetScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SubconsciousResetScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Reset is where you start training new instructions.',
            style: AppTypography.h1.copyWith(fontSize: 32, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
