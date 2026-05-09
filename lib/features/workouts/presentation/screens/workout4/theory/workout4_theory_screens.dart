import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
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
    Future.delayed(const Duration(milliseconds: 2000), () {
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
              FadeInDown(
                delay: const Duration(milliseconds: 300),
                child: Text('The mind gets loud for a reason.', style: AppTypography.h2.copyWith(color: Colors.white, fontSize: 28), textAlign: TextAlign.center),
              ),
              const SizedBox(height: 12),
              FadeInDown(
                delay: const Duration(milliseconds: 1700),
                child: Text('Attention stayed too long.', style: AppTypography.p.copyWith(color: Colors.white.withOpacity(0.8), fontSize: 16), textAlign: TextAlign.center),
              ),
              const SizedBox(height: 12),
              FadeInDown(
                delay: const Duration(milliseconds: 3100),
                child: Text('Today you train the release.', style: AppTypography.p.copyWith(color: Colors.white.withOpacity(0.8), fontSize: 16), textAlign: TextAlign.center),
              ),
              const Spacer(),
              Text('Workout start — attention mechanics load in 2 seconds.', style: AppTypography.columnHeader.copyWith(fontSize: 8, color: Colors.white.withOpacity(0.3))),
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: showCta ? 1 : 0,
                duration: const Duration(milliseconds: 350),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), padding: const EdgeInsets.symmetric(vertical: 16)),
                    onPressed: showCta ? widget.onNext : null,
                    child: Text('  Begin Workout', style: AppTypography.btnText.copyWith(color: AppColors.accent)),
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
  const Workout4MainNarrationScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Overthinking isn’t intelligence.\nAnd it isn’t weakness.\nIt’s what happens when attention keeps returning\nbecause the system thinks something still matters.\nThis isn’t about fixing thoughts.\nIt’s about training where attention goes.', 
            style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Text('Noise is attention without direction.', style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4CoreDefinitionScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4CoreDefinitionScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Overthinking is not too many thoughts.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('It is the same thought pattern being revisited\nbecause attention never disengaged.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text('Attention locks', style: AppTypography.columnHeader.copyWith(fontSize: 10, letterSpacing: 1.4)),
        ],
      ),
    );
  }
}

class Workout4ProtectiveLogicScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4ProtectiveLogicScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Your system follows a simple rule:', style: AppTypography.p.copyWith(fontSize: 18), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('“If attention keeps returning here,\nthis must matter.”', style: AppTypography.h2.copyWith(fontSize: 28), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('So it keeps producing noise\nto make sure nothing is missed.', style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4AttentionMistakeScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4AttentionMistakeScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('The system confuses attention\nwith danger.', style: AppTypography.h1.copyWith(fontSize: 34), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text('Attention is fuel. Not proof.', style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4NoiseBuildScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4NoiseBuildScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('When attention doesn’t release,\nthoughts don’t resolve.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('They replay.', style: AppTypography.h1.copyWith(fontSize: 38), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('Replay creates volume.\nVolume creates urgency.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4ExamplesIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4ExamplesIntroScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Text('How this looks in life:', style: AppTypography.h1.copyWith(fontSize: 34), textAlign: TextAlign.center),
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
  const Workout4CoreShiftScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('THE SHIFT', style: AppTypography.columnHeader.copyWith(fontSize: 10, letterSpacing: 1.4)),
          const SizedBox(height: 16),
          Text('Attention is a choice.', style: AppTypography.h1.copyWith(fontSize: 40), textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text('You don’t need to stop the thoughts.\nYou need to stop feeding them.', style: AppTypography.h2.copyWith(fontSize: 24, color: AppColors.ink.withOpacity(0.6)), textAlign: TextAlign.center),
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
  const Workout4MuscleSummaryScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Muscles Activated', style: AppTypography.h1.copyWith(fontSize: 34)),
          const SizedBox(height: 24),
          Text('Cognitive Distance', style: AppTypography.h2.copyWith(fontSize: 24)),
          const SizedBox(height: 8),
          Text('Attention Control', style: AppTypography.h2.copyWith(fontSize: 24)),
          const SizedBox(height: 8),
          Text('Urgency Resistance', style: AppTypography.h2.copyWith(fontSize: 24)),
          const SizedBox(height: 8),
          Text('Completion Tolerance', style: AppTypography.h2.copyWith(fontSize: 24)),
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
      nextButtonText: '  See the Insight',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('✨ What Just Changed', style: AppTypography.h1.copyWith(color: Colors.white, fontSize: 34), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text('You didn’t fix a problem.\nYou changed a mechanic.', style: AppTypography.p.copyWith(color: Colors.white.withOpacity(0.7), fontSize: 16), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4ClosingMainScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4ClosingMainScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('The mind was loud.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('You removed the fuel.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('The loop remains open.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('And you are still safe.', style: AppTypography.h2.copyWith(fontSize: 26, color: AppColors.accent), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4ClosingInsightScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4ClosingInsightScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Fear survives on reaction.', style: AppTypography.h1.copyWith(fontSize: 34), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text('Safety appears when reaction reduces.', style: AppTypography.h2.copyWith(fontSize: 28, color: AppColors.ink.withOpacity(0.6)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
