import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import '../widgets/workout3_content_layout.dart';

class Workout3EntryScreen extends StatefulWidget {
  final VoidCallback onNext;
  const Workout3EntryScreen({required this.onNext, super.key});

  @override
  State<Workout3EntryScreen> createState() => _Workout3EntryScreenState();
}

class _Workout3EntryScreenState extends State<Workout3EntryScreen> {
  bool showCta = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2200), () {
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
              Text('The body reacts first.', style: AppTypography.h2.copyWith(color: Colors.white, fontSize: 28), textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text('Meaning arrives after.', style: AppTypography.p.copyWith(color: Colors.white.withOpacity(0.8), fontSize: 16), textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text('Today you catch the split.', style: AppTypography.p.copyWith(color: Colors.white.withOpacity(0.8), fontSize: 16), textAlign: TextAlign.center),
              const Spacer(),
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

class Workout3MainNarrationIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3MainNarrationIntroScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Text('Safety is felt — not thought.', style: AppTypography.h2.copyWith(fontSize: 30), textAlign: TextAlign.center),
    );
  }
}

class Workout3BodyBeforeMindScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3BodyBeforeMindScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Body reacts first', style: AppTypography.h2.copyWith(fontSize: 28)),
          const SizedBox(height: 8),
          Text('Mind interprets', style: AppTypography.h2.copyWith(fontSize: 28)),
          const SizedBox(height: 8),
          Text('Alarm escalates', style: AppTypography.h2.copyWith(fontSize: 28)),
        ],
      ),
    );
  }
}

class Workout3GoalScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3GoalScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('This is not danger.', style: AppTypography.h2.copyWith(fontSize: 27)),
          const SizedBox(height: 10),
          Text('This sensation is allowed.', style: AppTypography.h2.copyWith(fontSize: 27)),
          const SizedBox(height: 10),
          Text('No reaction is required.', style: AppTypography.h2.copyWith(fontSize: 27)),
        ],
      ),
    );
  }
}

class Workout3ModernTriggersScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3ModernTriggersScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    const items = ['Caffeine', 'Heat', 'Hunger', 'Crowds', 'Stress', 'Silence'];
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < items.length; i++)
            FadeInDown(
              delay: Duration(milliseconds: 300 * i),
              duration: const Duration(milliseconds: 800),
              from: 10,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(items[i], style: AppTypography.h2.copyWith(fontSize: 24)),
              ),
            ),
          const SizedBox(height: 14),
          Text('Often these are not dangerous.\nBut the body does not care about explanation first.\nIt responds to sensation.', style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout3MisinterpretationLoopScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3MisinterpretationLoopScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Misinterpretation keeps the alarm alive.', style: AppTypography.h2.copyWith(fontSize: 28), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('A signal appears.\nThe mind marks it.\nThe body prepares.\nThe preparation gets misread as proof.', style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout3ExampleCheckingScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3ExampleCheckingScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Continue',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('You check your body.', style: AppTypography.h2.copyWith(fontSize: 26)),
          const SizedBox(height: 8),
          Text('Heart. Breath. Balance.', style: AppTypography.h2.copyWith(fontSize: 24)),
          const SizedBox(height: 8),
          Text('Checking sends one message:', style: AppTypography.h2.copyWith(fontSize: 24)),
          const SizedBox(height: 8),
          Text('Still not safe.', style: AppTypography.h2.copyWith(fontSize: 28)),
        ],
      ),
    );
  }
}

class Workout3CoreMessageScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3CoreMessageScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Begin Training',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('My body is allowed to feel sensations.', style: AppTypography.h2.copyWith(fontSize: 27), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text('Sensations are information — not proof.', style: AppTypography.h2.copyWith(fontSize: 25), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout3TransitionToDrillsScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3TransitionToDrillsScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Start Body Safety Training',
      child: Text('You are not removing sensation.\nYou are removing automatic reaction.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
    );
  }
}

class Workout3DrillsCompleteScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onHome;
  const Workout3DrillsCompleteScreen({required this.onNext, required this.onHome, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onHome,
      nextButtonText: '  Continue to Muscle Summary',
      showHome: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('You trained three skills today:', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('Splitting sensation from meaning\nBreaking collapse language\nHolding without reaction', style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.5)), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text('That is body learning under pressure.', style: AppTypography.p.copyWith(fontSize: 13, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}

class Workout3MuscleSummaryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3MuscleSummaryScreen(
      {required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
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
          const _MuscleRow(label: 'Sensation Separation', isActivated: true),
          const _MuscleRow(label: 'Non-Reactivity', isActivated: true),
          const SizedBox(height: 48),
          Center(
            child: Text(
              'Automatic safety is built through repetition.',
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

class Workout3ClosingTransitionScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3ClosingTransitionScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      isDark: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('✨ What Just Changed', style: AppTypography.h1.copyWith(color: Colors.white, fontSize: 34), textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text('The body was not the problem.', style: AppTypography.h2.copyWith(color: Colors.white.withOpacity(0.75), fontSize: 22), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('Reaction was.', style: AppTypography.h2.copyWith(color: Colors.white.withOpacity(0.75), fontSize: 22), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout3ClosingCoreScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3ClosingCoreScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('You did not calm your body.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text('You taught it something new.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text('A sensation can exist—', style: AppTypography.h2.copyWith(fontSize: 25), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text('without reaction following.', style: AppTypography.h2.copyWith(fontSize: 25), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout3ClosingInsightScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3ClosingInsightScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Fear survives on reaction.', style: AppTypography.h1.copyWith(fontSize: 34), textAlign: TextAlign.center),
          const SizedBox(height: 14),
          Text('Safety appears when reaction reduces.', style: AppTypography.h2.copyWith(fontSize: 28), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout3ClosingForwardLookScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3ClosingForwardLookScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Continue to Notice',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Next, you will train\nhow thought restarts the loop.\nAnd how to interrupt it earlier.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout3NoticeScreen extends StatelessWidget {
  final String line1;
  final String line2;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final String cta;
  const Workout3NoticeScreen({required this.line1, required this.line2, required this.onNext, required this.onBack, this.cta = '  Continue', super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: cta,
      isDark: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(line1, style: AppTypography.h2.copyWith(color: Colors.white, fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 14),
          Text(line2, style: AppTypography.h2.copyWith(color: Colors.white.withOpacity(0.75), fontSize: 24), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

