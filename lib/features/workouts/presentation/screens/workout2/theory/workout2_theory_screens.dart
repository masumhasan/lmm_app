import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import '../widgets/workout2_content_layout.dart';

class Workout2EntryScreen extends StatefulWidget {
  final VoidCallback onNext;
  const Workout2EntryScreen({required this.onNext, super.key});

  @override
  State<Workout2EntryScreen> createState() => _Workout2EntryScreenState();
}

class _Workout2EntryScreenState extends State<Workout2EntryScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _ringController;
  bool _showCTA = false;

  @override
  void initState() {
    super.initState();
    _ringController = AnimationController(vsync: this, duration: const Duration(seconds: 13))..repeat();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showCTA = true);
    });
  }

  @override
  void dispose() {
    _ringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: AnimatedBuilder(
                animation: _ringController,
                builder: (context, _) {
                  final t = _ringController.value;
                  final scale = t < 0.46 ? 1 + (t / 0.46) * 0.18 : 1.18 - ((t - 0.46) / 0.54) * 0.18;
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 440,
                      height: 440,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.18), width: 2),
                      ),
                      child: Center(
                        child: Container(
                          width: 380,
                          height: 380,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text('The alarm feels bigger than it is.', style: AppTypography.h2.copyWith(color: Colors.white, fontSize: 28), textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  Text('The loop makes it grow.', style: AppTypography.p.copyWith(color: Colors.white.withOpacity(0.7), fontSize: 16), textAlign: TextAlign.center),
                  const SizedBox(height: 6),
                  Text('Today you will see where.', style: AppTypography.p.copyWith(color: Colors.white.withOpacity(0.7), fontSize: 16), textAlign: TextAlign.center),
                  const SizedBox(height: 14),
                  Text(
                    'Training focus: catch the second alarm.',
                    style: AppTypography.columnHeader.copyWith(color: Colors.white.withOpacity(0.45), fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  AnimatedOpacity(
                    opacity: _showCTA ? 1 : 0,
                    duration: const Duration(milliseconds: 350),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _showCTA ? widget.onNext : null,
                        child: Text('  Begin Workout', style: AppTypography.btnText.copyWith(color: AppColors.accent)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Workout2IntroNarrationScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2IntroNarrationScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Awareness changes what you follow.', style: AppTypography.h2.copyWith(fontSize: 30, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Text('Training focus: recognize the echo.', style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.3))),
        ],
      ),
    );
  }
}

class Workout2AlarmLoopDefinitionScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2AlarmLoopDefinitionScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'An alarm in the mind triggers a reaction in the body.\nThen the body reaction triggers a second alarm in the mind.',
            style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.55), height: 1.6),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          _LoopDiagram(),
          const SizedBox(height: 24),
          Text('A protection system reacting to itself.', style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.35), fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}

class _LoopDiagram extends StatefulWidget {
  @override
  State<_LoopDiagram> createState() => _LoopDiagramState();
}

class _LoopDiagramState extends State<_LoopDiagram> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => Transform.rotate(
          angle: _controller.value * 6.28318,
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.ink.withOpacity(0.16), width: 1.5)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Mind', style: AppTypography.columnHeader.copyWith(fontSize: 9)),
                  const SizedBox(width: 10),
                  Icon(LucideIcons.repeat, size: 14, color: AppColors.ink.withOpacity(0.3)),
                  const SizedBox(width: 10),
                  Text('Body', style: AppTypography.columnHeader.copyWith(fontSize: 9)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Workout2AlarmLoopExplanationScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2AlarmLoopExplanationScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  See Real-Life Examples',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Mind → body → mind → body…', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('Until it feels endless.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 22),
          Text('This is not new information.\nIt is the same signal being re-read.', style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout2ExampleScreen extends StatelessWidget {
  final String title;
  final List<String> leftLines;
  final List<String> rightLines;
  final String realityLine;
  final String microLine;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final String cta;

  const Workout2ExampleScreen({
    required this.title,
    required this.leftLines,
    required this.rightLines,
    required this.realityLine,
    required this.microLine,
    required this.onNext,
    required this.onBack,
    this.cta = '  Next Example',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: cta,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTypography.h2.copyWith(fontSize: 30), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sensation / Body', style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.28))),
                    const SizedBox(height: 10),
                    for (final line in leftLines) Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(line, style: AppTypography.p.copyWith(fontSize: 13))),
                  ],
                ),
              ),
              Container(width: 1, height: 130, color: AppColors.line.withOpacity(0.3)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('System / Meaning', style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.28))),
                      const SizedBox(height: 10),
                      for (final line in rightLines)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(line, style: AppTypography.p.copyWith(fontSize: 13, fontStyle: FontStyle.italic)),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(realityLine, style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text(microLine, style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.25)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout2LoopIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2LoopIntroScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 250,
            width: 250,
            child: DotLottieLoader.fromAsset(
              'assets/lotties/brain.lottie',
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
          Text('The Loop That Feels Like the Alarm', style: AppTypography.h2.copyWith(fontSize: 28), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('The same signal gets interpreted twice.', style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Text('Mind → Body → Mind → Body', style: AppTypography.columnHeader.copyWith(fontSize: 10, letterSpacing: 1.4)),
        ],
      ),
    );
  }
}

class Workout2LoopStepsScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2LoopStepsScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<Workout2LoopStepsScreen> createState() => _Workout2LoopStepsScreenState();
}

class _Workout2LoopStepsScreenState extends State<Workout2LoopStepsScreen> {
  int _step = 0;
  @override
  Widget build(BuildContext context) {
    final steps = [
      'Something neutral appears.\n(A fast heartbeat, a tight chest, a thought, a memory, a situation)',
      'The system responds with protection:\n"This could be dangerous."',
      'The body prepares:\nHeart speeds up · Muscles tighten · Breath changes',
      'The second alarm (echo):\n"See? That confirms it."',
    ];
    return Workout2ContentLayout(
      onBack: widget.onBack,
      onNext: _step < 3 ? () => setState(() => _step++) : widget.onNext,
      nextButtonText: _step < 3 ? '  Next' : '  Continue',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Training Set: 4-step loop', style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.3))),
          const SizedBox(height: 18),
          for (int i = 0; i <= _step; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: FadeIn(
                duration: i == 3 ? const Duration(milliseconds: 900) : const Duration(milliseconds: 500),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.line.withOpacity(0.4))),
                  child: Text(steps[i], style: AppTypography.p.copyWith(fontSize: i == 3 ? 13.5 : 13, color: AppColors.ink.withOpacity(i == 3 ? 0.75 : 0.6))),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class Workout2LoopPennyDropScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2LoopPennyDropScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      isDark: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('The loop does not grow at the first signal.\nIt grows when reaction becomes proof.\nThat is the second alarm.', style: AppTypography.h2.copyWith(fontSize: 26, color: Colors.white), textAlign: TextAlign.center),
          const SizedBox(height: 22),
          Text('Nothing new happened.\nThe echo was treated as new.', style: AppTypography.p.copyWith(fontSize: 14, color: Colors.white.withOpacity(0.65)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout2ControlReturnsScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2ControlReturnsScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('You do not stop the first signal.\nYou do not change the body.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
          const SizedBox(height: 18),
          Text('You stop answering the echo.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout2FinalLockInScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2FinalLockInScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Continue to Reps',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('When the body reacts,\nnothing new has happened.\nThe same alarm is echoing.\nThe loop fades when the echo is not answered.', style: AppTypography.h2.copyWith(fontSize: 23), textAlign: TextAlign.center),
          const SizedBox(height: 18),
          Text('Next: 3 drills. No scoring. Just reps.', style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.28))),
        ],
      ),
    );
  }
}

class Workout2MuscleSummaryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2MuscleSummaryScreen(
      {required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
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
          const _MuscleRow(label: 'Loop Disruption', isActivated: true),
          const _MuscleRow(label: 'Escalation Awareness', isActivated: true),
          const SizedBox(height: 48),
          Center(
            child: Text(
              'Automatic interruption is built through repetition.',
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

class Workout2ClosingTransitionScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2ClosingTransitionScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
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
          Text('Workout 2 Complete', style: AppTypography.h1.copyWith(color: Colors.white, fontSize: 32), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('The alarm was not endless.\nThe loop made it feel that way.', style: AppTypography.h2.copyWith(color: Colors.white.withOpacity(0.7), fontSize: 22), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout2ClosingCoreScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2ClosingCoreScreen({required this.onNext, required this.onBack, super.key});
  @override
  State<Workout2ClosingCoreScreen> createState() => _Workout2ClosingCoreScreenState();
}

class _Workout2ClosingCoreScreenState extends State<Workout2ClosingCoreScreen> {
  int _visible = 0;
  final lines = const [
    'Today you saw the mechanism.',
    'A signal appeared.',
    'The system reacted.',
    'Then it reacted again to its own reaction.',
    '',
    'That second reaction is the echo.',
    'The loop grows',
    'when the echo is treated as new.',
  ];
  @override
  void initState() {
    super.initState();
    _run();
  }

  Future<void> _run() async {
    for (var i = 0; i < lines.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1200));
      if (!mounted) return;
      setState(() => _visible = i + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: widget.onNext,
      onBack: widget.onBack,
      nextButtonText: '  Continue to Notice',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < lines.length; i++)
            if (i < _visible)
              Padding(
                padding: EdgeInsets.only(bottom: lines[i].isEmpty ? 10 : 8),
                child: Text(
                  lines[i],
                  style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.62), fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
        ],
      ),
    );
  }
}

class Workout2NoticeScreen extends StatelessWidget {
  final String line1;
  final String line2;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final String cta;
  const Workout2NoticeScreen({
    required this.line1,
    required this.line2,
    required this.onNext,
    required this.onBack,
    this.cta = '  Continue',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: cta,
      isDark: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(child: Text(line1, style: AppTypography.h2.copyWith(fontSize: 26, color: Colors.white), textAlign: TextAlign.center)),
          const SizedBox(height: 24),
          FadeIn(delay: const Duration(milliseconds: 900), child: Text(line2, style: AppTypography.h2.copyWith(fontSize: 24, color: Colors.white.withOpacity(0.75)), textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}

