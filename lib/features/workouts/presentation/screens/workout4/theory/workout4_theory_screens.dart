import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import '../widgets/workout4_content_layout.dart';

class Workout4EntryScreen extends StatefulWidget {
  final VoidCallback onNext;
  const Workout4EntryScreen({required this.onNext, super.key});
  @override
  State<Workout4EntryScreen> createState() => _Workout4EntryScreenState();
}

class _Workout4EntryScreenState extends State<Workout4EntryScreen> {
  bool showCta = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) setState(() => showCta = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C35),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              FadeIn(
                duration: const Duration(seconds: 2),
                child: DotLottieLoader.fromAsset(
                  'assets/lotties/clouds.lottie',
                  frameBuilder: (BuildContext context, DotLottie? dotlottie) {
                    if (dotlottie != null) {
                      return Lottie.memory(
                        dotlottie.animations.values.single,
                        height: 200,
                      );
                    } else {
                      return const SizedBox(height: 200);
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              FadeInDown(
                delay: const Duration(milliseconds: 300),
                child: Text('The mind gets loud for a reason.',
                    style: AppTypography.h2
                        .copyWith(color: Colors.white, fontSize: 28),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 12),
              FadeInDown(
                delay: const Duration(milliseconds: 1700),
                child: Text('Attention stayed too long.',
                    style: AppTypography.p
                        .copyWith(color: Colors.white.withOpacity(0.8), fontSize: 16),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 12),
              FadeInDown(
                delay: const Duration(milliseconds: 3100),
                child: Text('Today you train the release.',
                    style: AppTypography.p
                        .copyWith(color: Colors.white.withOpacity(0.8), fontSize: 16),
                    textAlign: TextAlign.center),
              ),
              const Spacer(),
              Text('Workout start — muscles load in 2 seconds.',
                  style: AppTypography.columnHeader
                      .copyWith(fontSize: 8, color: Colors.white.withOpacity(0.3))),
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: showCta ? 1 : 0,
                duration: const Duration(milliseconds: 350),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.symmetric(vertical: 16)),
                    onPressed: showCta ? widget.onNext : null,
                    child: Text('  Begin Training',
                        style: AppTypography.btnText
                            .copyWith(color: const Color(0xFF1C1C35))),
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

class Workout4MainNarrationScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4MainNarrationScreen(
      {required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Center(
        child: Text(
          'Noise is attention without direction.',
          style: AppTypography.h2.copyWith(
            fontSize: 22,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Workout4CoreDefinitionScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4CoreDefinitionScreen(
      {required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Overthinking is not too many thoughts.',
              style: AppTypography.h2.copyWith(fontSize: 26),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(
              'It is one pattern being revisited because attention never released.',
              style: AppTypography.h2.copyWith(fontSize: 24),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text('CORE DEFINITION',
              style: AppTypography.columnHeader
                  .copyWith(fontSize: 10, letterSpacing: 1.4)),
        ],
      ),
    );
  }
}

class Workout4ProtectiveLogicScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4ProtectiveLogicScreen(
      {required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('The mind feels it MUST complete.',
              style: AppTypography.h2.copyWith(fontSize: 26),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text("“If I don't finish this\nI am not safe.”",
              style: AppTypography.h1.copyWith(fontSize: 34),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text('PROTECTIVE LOGIC',
              style: AppTypography.columnHeader
                  .copyWith(fontSize: 10, letterSpacing: 1.4)),
        ],
      ),
    );
  }
}

class Workout4AttentionMistakeScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4AttentionMistakeScreen(
      {required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('The system confuses attention with urgency.',
              style: AppTypography.h1.copyWith(fontSize: 34),
              textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text('Attention is fuel. Not fact.',
              style: AppTypography.p
                  .copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.45)),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4NoiseBuildScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4NoiseBuildScreen(
      {required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeInUp(
            child: Text(
                "When attention doesn't release,\nthoughts don't resolve.",
                style: AppTypography.h2.copyWith(fontSize: 26),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 12),
          FadeIn(
            delay: const Duration(milliseconds: 800),
            child: Text('They replay.',
                style: AppTypography.h1.copyWith(fontSize: 38),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 12),
          FadeInUp(
            delay: const Duration(milliseconds: 1600),
            child: Text('Replay creates volume.\nVolume creates urgency.',
                style: AppTypography.h2.copyWith(fontSize: 24),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}

class Workout4ExamplesIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4ExamplesIntroScreen(
      {required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('How this looks in life:',
              style: AppTypography.h1.copyWith(fontSize: 34),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('Attention looking for a target.',
              style: AppTypography.p
                  .copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.45)),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4ExampleScreen extends StatelessWidget {
  final String title;
  final List<String> lines;
  final String neutralClose;
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4ExampleScreen({required this.title, required this.lines, required this.neutralClose, required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTypography.columnHeader.copyWith(fontSize: 10, letterSpacing: 1.4)),
          const SizedBox(height: 24),
          for (final line in lines)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(line, style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
            ),
          const SizedBox(height: 16),
          const SizedBox(
            width: 40,
            child: Divider(thickness: 1),
          ),
          const SizedBox(height: 16),
          Text(neutralClose, style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4WhyThinkingFailsScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4WhyThinkingFailsScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Trying to think your way out of noise\nkeeps attention exactly where the loop wants it.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text('More thinking = More fuel', style: AppTypography.columnHeader.copyWith(fontSize: 10, letterSpacing: 1.4)),
        ],
      ),
    );
  }
}

class Workout4CoreShiftScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4CoreShiftScreen(
      {required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('THE SHIFT',
              style: AppTypography.columnHeader
                  .copyWith(fontSize: 10, letterSpacing: 1.4)),
          const SizedBox(height: 16),
          Text('Attention is a choice.',
              style: AppTypography.h1.copyWith(fontSize: 40),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text(
              "You don't need to fix the thoughts.\nYou need to train who is in control.",
              style: AppTypography.h2
                  .copyWith(fontSize: 24, color: AppColors.ink.withOpacity(0.6)),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4TransitionToDrillsScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4TransitionToDrillsScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: 'Start Attention Training',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('You are not solving thoughts.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('You are training attention under noise.', style: AppTypography.h2.copyWith(fontSize: 26, color: AppColors.ink.withOpacity(0.5)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4DrillsCompleteScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onHome;
  const Workout4DrillsCompleteScreen({required this.onNext, required this.onHome, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onHome,
      nextButtonText: 'Continue to Muscle Summary',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('You trained three skills today:', style: AppTypography.h2.copyWith(fontSize: 28), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Text('• You starved attention.\n• You broke urgency.\n• You denied completion.', style: AppTypography.p.copyWith(fontSize: 16, height: 1.6), textAlign: TextAlign.center),
          const SizedBox(height: 32),
          Text('Overthinking runs on habits.', style: AppTypography.p.copyWith(fontSize: 14, fontStyle: FontStyle.italic, color: AppColors.ink.withOpacity(0.45))),
        ],
      ),
    );
  }
}

class Workout4MuscleSummaryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4MuscleSummaryScreen(
      {required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Continue to Closing',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Muscles Activated',
                style: AppTypography.h1
                    .copyWith(fontSize: 34, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 48),
          const _MuscleRow(label: 'Cognitive Distance', isActivated: true),
          const _MuscleRow(label: 'Attention Control', isActivated: true),
          const _MuscleRow(label: 'Urgency Resistance', isActivated: true),
          const _MuscleRow(label: 'Completion Tolerance', isActivated: true),
          const SizedBox(height: 48),
          Center(
            child: Text(
              '"Repetition builds automatic strength."',
              style: AppTypography.p
                  .copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.4)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'This screen shows muscles only. No reps log here.',
              style: AppTypography.columnHeader.copyWith(
                fontSize: 8,
                color: AppColors.ink.withOpacity(0.15),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _MuscleRow extends StatelessWidget {
  final String label;
  final bool isActivated;
  const _MuscleRow({required this.label, required this.isActivated});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTypography.columnHeader
                .copyWith(fontSize: 12, color: AppColors.ink, letterSpacing: 1.0),
          ),
          if (isActivated)
            Text(
              'ACTIVATED',
              style: AppTypography.mono.copyWith(
                  fontSize: 9,
                  color: const Color(0xFF10B981),
                  fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}

class Workout4ClosingIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4ClosingIntroScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      isDark: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            child: Text('What Just Changed',
                style: AppTypography.h1.copyWith(color: Colors.white, fontSize: 34),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 16),
          FadeIn(
            delay: const Duration(milliseconds: 700),
            child: Text('The system no longer runs attention automatically.',
                style: AppTypography.p.copyWith(color: Colors.white.withOpacity(0.65), fontSize: 16),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}

class Workout4ClosingMainScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4ClosingMainScreen({required this.onNext, required this.onBack, super.key});
  @override
  State<Workout4ClosingMainScreen> createState() => _Workout4ClosingMainScreenState();
}

class _Workout4ClosingMainScreenState extends State<Workout4ClosingMainScreen> {
  bool _showCta = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3400), () {
      if (mounted) setState(() => _showCta = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: widget.onNext,
      onBack: widget.onBack,
      showNextButton: _showCta,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: Text('You didn\'t stop thoughts today.',
                style: AppTypography.h2.copyWith(fontSize: 24)),
          ),
          const SizedBox(height: 10),
          FadeInDown(
            delay: const Duration(milliseconds: 600),
            duration: const Duration(milliseconds: 500),
            child: Text('You stopped obeying them.',
                style: AppTypography.h2.copyWith(fontSize: 24)),
          ),
          const SizedBox(height: 20),
          FadeInDown(
            delay: const Duration(milliseconds: 1200),
            duration: const Duration(milliseconds: 500),
            child: Text('You noticed the moment\nyour system tried to take control.',
                style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.6))),
          ),
          const SizedBox(height: 10),
          FadeInDown(
            delay: const Duration(milliseconds: 1800),
            duration: const Duration(milliseconds: 500),
            child: Text('And you interrupted it\nbefore it turned into noise.',
                style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.6))),
          ),
          const SizedBox(height: 20),
          FadeInDown(
            delay: const Duration(milliseconds: 2600),
            duration: const Duration(milliseconds: 500),
            child: Text('That is how overthinking weakens.',
                style: AppTypography.h2.copyWith(fontSize: 22, color: AppColors.accent)),
          ),
        ],
      ),
    );
  }
}

class Workout4ClosingInsightScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4ClosingInsightScreen({required this.onNext, required this.onBack, super.key});
  @override
  State<Workout4ClosingInsightScreen> createState() => _Workout4ClosingInsightScreenState();
}

class _Workout4ClosingInsightScreenState extends State<Workout4ClosingInsightScreen> {
  bool _showLine2 = false;
  bool _showCta = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _showLine2 = true);
    });
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) setState(() => _showCta = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: widget.onNext,
      onBack: widget.onBack,
      showNextButton: _showCta,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            child: Text('Thoughts only control you',
                style: AppTypography.h1.copyWith(fontSize: 32),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 8),
          AnimatedOpacity(
            opacity: _showLine2 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Text('when you treat them as instructions.',
                style: AppTypography.h1.copyWith(fontSize: 32),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
