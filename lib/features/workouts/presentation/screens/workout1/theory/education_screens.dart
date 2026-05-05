import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/workout1_content_layout.dart';

/// Workout1_Education_Intro
class Workout1EducationIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1EducationIntroScreen({required this.onNext, required this.onBack, super.key});

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
              '"Stories feel convincing."',
              style: AppTypography.h2.copyWith(fontSize: 26, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          FadeIn(
            delay: const Duration(milliseconds: 1200),
            duration: const Duration(milliseconds: 800),
            child: Text(
              '"Reality is quieter."',
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

/// Workout1_Story_Core
class Workout1StoryCoreScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1StoryCoreScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<Workout1StoryCoreScreen> createState() => _Workout1StoryCoreScreenState();
}

class _Workout1StoryCoreScreenState extends State<Workout1StoryCoreScreen> {
  bool _showSecondLine = false;
  bool _showMicroLine = false;
  bool _showCTA = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _showSecondLine = true);
    });
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) setState(() => _showMicroLine = true);
    });
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) setState(() => _showCTA = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: widget.onNext,
      onBack: widget.onBack,
      showNextButton: _showCTA,
      buttonDelayMs: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'This is a thought.',
              style: AppTypography.h1.copyWith(
                fontSize: 32,
                fontStyle: FontStyle.italic,
                color: AppColors.ink.withOpacity(0.4),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          AnimatedOpacity(
            opacity: _showSecondLine ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: Text(
              'This is not a fact.',
              style: AppTypography.h1.copyWith(fontSize: 32, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          AnimatedOpacity(
            opacity: _showMicroLine ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            child: Text(
              'Separation cue: story ≠ fact',
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

/// Workout1_Why_Stories
class Workout1WhyStoriesScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1WhyStoriesScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<Workout1WhyStoriesScreen> createState() => _Workout1WhyStoriesScreenState();
}

class _Workout1WhyStoriesScreenState extends State<Workout1WhyStoriesScreen> {
  int _visibleLines = 0;
  bool _showCTA = false;

  final _lines = ['Silence', 'Uncertainty', 'Missing information', 'So it fills the gap.'];

  @override
  void initState() {
    super.initState();
    _revealLines();
  }

  void _revealLines() async {
    for (var i = 0; i < _lines.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1200));
      if (!mounted) return;
      setState(() => _visibleLines = i + 1);
    }
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _showCTA = true);
  }

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: widget.onNext,
      onBack: widget.onBack,
      showNextButton: _showCTA,
      buttonDelayMs: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < _lines.length; i++)
            AnimatedOpacity(
              opacity: _visibleLines > i ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  _lines[i],
                  style: i < 3
                      ? AppTypography.h2.copyWith(
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                          color: AppColors.ink.withOpacity(0.7),
                        )
                      : AppTypography.h2.copyWith(fontSize: 24, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Workout1_Reframe
class Workout1ReframeScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1ReframeScreen({required this.onNext, required this.onBack, super.key});

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
              '"This is instinct."',
              style: AppTypography.h2.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          FadeIn(
            delay: const Duration(milliseconds: 1000),
            duration: const Duration(milliseconds: 800),
            child: Text(
              '"Not failure."',
              style: AppTypography.h2.copyWith(
                fontSize: 28,
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
