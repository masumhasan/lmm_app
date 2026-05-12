import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import '../widgets/workout4_content_layout.dart';

class _NoticeBase extends StatelessWidget {
  final List<String> lines;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final String nextButtonText;

  const _NoticeBase({
    required this.lines,
    required this.onNext,
    required this.onBack,
    this.nextButtonText = '  Continue',
  });

  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      isDark: true,
      nextButtonText: nextButtonText,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < lines.length; i++) ...[
            if (i > 0) const SizedBox(height: 28),
            FadeIn(
              delay: Duration(milliseconds: 300 + i * 900),
              duration: const Duration(milliseconds: 400),
              child: Text(
                lines[i],
                style: AppTypography.h2.copyWith(
                  color: i == 0
                      ? Colors.white
                      : Colors.white.withOpacity(0.65),
                  fontSize: i == 0 ? 26 : 22,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class Workout4Notice1Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4Notice1Screen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) => _NoticeBase(
        lines: const ['A thought will appear.', 'It will ask for attention.'],
        onNext: onNext,
        onBack: onBack,
      );
}

class Workout4Notice2Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4Notice2Screen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) => _NoticeBase(
        lines: const [
          'It will feel important.',
          'Not because it is—',
          'but because attention stayed.',
        ],
        onNext: onNext,
        onBack: onBack,
      );
}

class Workout4Notice3Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4Notice3Screen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) => _NoticeBase(
        lines: const [
          'It will come back again—',
          'and again.',
          "That's the loop.",
        ],
        onNext: onNext,
        onBack: onBack,
      );
}

class Workout4Notice4Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4Notice4Screen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) => _NoticeBase(
        lines: const [
          'It will try to finish.',
          'To solve.',
          'To close the loop.',
        ],
        onNext: onNext,
        onBack: onBack,
      );
}

class Workout4Notice5Screen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4Notice5Screen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) => _NoticeBase(
        lines: const [
          'This is where it runs—',
          'when attention stays.',
          "You'll see it this time.",
        ],
        onNext: onNext,
        onBack: onBack,
        nextButtonText: '  Continue to Journal',
      );
}
