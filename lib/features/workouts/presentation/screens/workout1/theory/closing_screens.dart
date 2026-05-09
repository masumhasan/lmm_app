import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import '../widgets/workout1_content_layout.dart';

/// Workout1_Closing_Intro
class Workout1ClosingIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1ClosingIntroScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      isDark: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: DotLottieLoader.fromAsset(
              'assets/lotties/workout_complete.lottie',
              frameBuilder: (BuildContext context, DotLottie? lottie) {
                if (lottie != null) {
                  return Lottie.memory(lottie.animations.values.single);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Workout Complete',
            style: AppTypography.h1.copyWith(color: Colors.white, fontSize: 32),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Muscles Activated Today',
            style: AppTypography.h2.copyWith(color: Colors.white.withOpacity(0.7), fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            '"Stories feel real. Separation changes position."',
            style: AppTypography.p.copyWith(
              color: Colors.white.withOpacity(0.4),
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Workout1_Closing_Message — Core insight lock
class Workout1ClosingMessageScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1ClosingMessageScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<Workout1ClosingMessageScreen> createState() => _Workout1ClosingMessageScreenState();
}

class _Workout1ClosingMessageScreenState extends State<Workout1ClosingMessageScreen> {
  int _visibleLines = 0;
  bool _showCTA = false;

  final _lines = [
    'Your system will still create stories.',
    'It will still guess.',
    'But now you can notice the story',
    'instead of becoming it.',
  ];

  @override
  void initState() {
    super.initState();
    _revealLines();
  }

  void _revealLines() async {
    for (var i = 0; i < _lines.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1400));
      if (!mounted) return;
      setState(() => _visibleLines = i + 1);
    }
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) setState(() => _showCTA = true);
  }

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: widget.onNext,
      onBack: widget.onBack,
      isDark: true,
      showNextButton: _showCTA,
      nextButtonText: '  Continue to Notice',
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
                  '"${_lines[i]}"',
                  style: AppTypography.h2.copyWith(
                    fontSize: 22,
                    color: Colors.white.withOpacity(_visibleLines > i ? 0.9 : 0.0),
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Workout1_Notice_1 — Story Formation
class Workout1Notice1Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1Notice1Screen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      isDark: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 400),
            child: Text(
              '"A thought will appear…"',
              style: AppTypography.h2.copyWith(color: Colors.white, fontSize: 24, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          FadeIn(
            delay: const Duration(milliseconds: 1600),
            duration: const Duration(milliseconds: 400),
            child: Text(
              '"It will sound like a conclusion."',
              style: AppTypography.h2.copyWith(
                color: Colors.white.withOpacity(0.7),
                fontSize: 24,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// Workout1_Notice_2 — Meaning Before Evidence
class Workout1Notice2Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1Notice2Screen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      isDark: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 400),
            child: Text(
              '"Meaning will arrive before evidence."',
              style: AppTypography.h2.copyWith(color: Colors.white, fontSize: 24, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          FadeIn(
            delay: const Duration(milliseconds: 1600),
            duration: const Duration(milliseconds: 400),
            child: Text(
              '"It will feel true."',
              style: AppTypography.h2.copyWith(
                color: Colors.white.withOpacity(0.7),
                fontSize: 24,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// Workout1_Notice_3 — Separation Moment
class Workout1Notice3Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1Notice3Screen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      isDark: true,
      nextButtonText: '  Continue to Journal',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 400),
            child: Text(
              '"The story will still be there."',
              style: AppTypography.h2.copyWith(color: Colors.white, fontSize: 24, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          FadeIn(
            delay: const Duration(milliseconds: 1800),
            duration: const Duration(milliseconds: 400),
            child: Text(
              '"You won\'t be inside it."',
              style: AppTypography.h2.copyWith(
                color: Colors.white.withOpacity(0.7),
                fontSize: 24,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
