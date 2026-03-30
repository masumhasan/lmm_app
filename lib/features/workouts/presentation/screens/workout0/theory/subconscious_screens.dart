import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lmm_app/shared/widgets/theory_card.dart';

class SubconsciousTitleScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SubconsciousTitleScreen({
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
          FadeInDown(
            child: Text(
              'The Training System\nHow Repetition Builds Muscle',
              style: AppTypography.h1.copyWith(
                fontSize: 28,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Muscle Focus: Attention Control',
            style: AppTypography.columnHeader.copyWith(
              fontSize: 8,
              color: AppColors.accent,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 32),
          FadeInUp(
            delay: const Duration(milliseconds: 1000),
            child: Text(
              '“It learns by repetition.”',
              style: AppTypography.p.copyWith(
                fontSize: 16,
                color: AppColors.ink.withOpacity(0.4),
              ),
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
  const IcebergModelScreen({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Iceberg Image
          Center(
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(
                'assets/images/iceburg-ui-x.png',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
          ),

          // Layered Text - Positioned to match the reference image
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: 350), // Position "THOUGHTS" a bit lower
                Text(
                  'THOUGHTS',
                  style: AppTypography.columnHeader.copyWith(
                    fontSize: 10, // Made it bigger
                    color: Colors.white, // All text white
                    letterSpacing: 2.5,
                    shadows: [
                      const Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 2.0,
                        color: Colors.black87,
                      ),
                      const Shadow(
                        offset: Offset(0, -1),
                        blurRadius: 2.0,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 120,
                ), // Gap to the center of the bottom part
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Text(
                        'Imagine your mind\n as an iceberg.',
                        style: AppTypography.h2.copyWith(
                          fontSize: 22,
                          height: 1.2,
                          color: Colors.white,
                          shadows: [
                            const Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 3.0,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'The tiny part at the top\n is what you’re aware of.',
                        style: AppTypography.p.copyWith(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                          shadows: [
                            const Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 2.0,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IcebergBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class IcebergContentsScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const IcebergContentsScreen({
    required this.onNext,
    required this.onBack,
    super.key,
  });

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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              child: TheoryCard(
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
    return Path()
      ..moveTo(size.width / 2, 0)
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
  const SubconsciousControlScreen({
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
          Text(
            'This training system runs most of your day automatically, without asking.',
            style: AppTypography.h2.copyWith(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            'Mostly automatic',
            style: AppTypography.h1.copyWith(
              fontSize: 32,
              fontStyle: FontStyle.italic,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 48),
          Text(
            '“That’s why change can feel hard, even when you want it.”',
            style: AppTypography.p.copyWith(
              fontSize: 14,
              color: AppColors.ink.withOpacity(0.35),
            ),
          ),
        ],
      ),
    );
  }
}

class SubconsciousRuleScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SubconsciousRuleScreen({
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
          Text(
            'Your training system doesn’t follow what is true.\nIt follows what is repeated.',
            style: AppTypography.h1.copyWith(
              fontSize: 28,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            'Not because it’s real, but because it’s familiar.',
            style: AppTypography.p.copyWith(
              fontSize: 16,
              color: AppColors.ink.withOpacity(0.5),
            ),
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
  const SubconsciousOldScriptsScreen({
    required this.onNext,
    required this.onBack,
    super.key,
  });

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
              child: TheoryCard(
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
            style: AppTypography.p.copyWith(
              fontSize: 16,
              color: AppColors.ink.withOpacity(0.5),
            ),
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
  const SubconsciousResetScreen({
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
          Text(
            'Reset is where you start training new instructions.',
            style: AppTypography.h1.copyWith(
              fontSize: 32,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
