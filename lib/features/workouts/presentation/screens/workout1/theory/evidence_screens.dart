import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import '../widgets/workout1_content_layout.dart';

/// Workout1_Evidence_Title
class Workout1EvidenceTitleScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1EvidenceTitleScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 250,
            width: 250,
            child: DotLottieLoader.fromAsset(
              'assets/lotties/Workout1_Evidence_Title.lottie',
              frameBuilder: (BuildContext context, DotLottie? lottie) {
                if (lottie != null) {
                  return Lottie.memory(lottie.animations.values.single);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Evidence vs Story',
            style: AppTypography.h1.copyWith(fontSize: 32, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            '"One question breaks spirals."',
            style: AppTypography.p.copyWith(
              fontSize: 16,
              color: AppColors.ink.withOpacity(0.4),
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Muscle Focus: Story Separation',
            style: AppTypography.columnHeader.copyWith(
              fontSize: 9,
              color: AppColors.ink.withOpacity(0.25),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Separation cue: evidence first',
            style: AppTypography.p.copyWith(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: AppColors.ink.withOpacity(0.3),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Workout1_Evidence_Rule
class Workout1EvidenceRuleScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1EvidenceRuleScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 800),
            child: Text(
              '"If you don\'t have proof —\nit\'s a story."',
              style: AppTypography.h1.copyWith(fontSize: 30, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          FadeIn(
            delay: const Duration(milliseconds: 1000),
            child: Text(
              'Separation Rep: evidence first',
              style: AppTypography.p.copyWith(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: AppColors.ink.withOpacity(0.3),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// Workout1_Transition_To_Drills
class Workout1TransitionToDrillsScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1TransitionToDrillsScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<Workout1TransitionToDrillsScreen> createState() => _Workout1TransitionToDrillsScreenState();
}

class _Workout1TransitionToDrillsScreenState extends State<Workout1TransitionToDrillsScreen> {
  final _fragments = [
    'What if this means something bad?',
    'They probably think differently of me.',
    "This doesn't feel right.",
  ];

  int _currentFragment = -1;

  @override
  void initState() {
    super.initState();
    _animateFragments();
  }

  void _animateFragments() async {
    for (var i = 0; i < _fragments.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1800));
      if (!mounted) return;
      setState(() => _currentFragment = i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: widget.onNext,
      onBack: widget.onBack,
      nextButtonText: '▶ Continue Reps',
      showHome: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Training begins',
            style: AppTypography.h2.copyWith(fontSize: 26, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Reps for Story Separation',
            style: AppTypography.p.copyWith(
              fontSize: 14,
              color: AppColors.ink.withOpacity(0.4),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          SizedBox(
            height: 80,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: _currentFragment >= 0
                  ? Text(
                      '"${_fragments[_currentFragment]}"',
                      key: ValueKey(_currentFragment),
                      style: AppTypography.p.copyWith(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: AppColors.ink.withOpacity(0.2),
                      ),
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
