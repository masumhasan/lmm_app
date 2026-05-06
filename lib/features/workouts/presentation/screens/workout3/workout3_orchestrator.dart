import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'drills/workout3_drill_screens.dart';
import 'reps/workout3_skill_reps_screens.dart';
import 'theory/workout3_journal_screens.dart';
import 'theory/workout3_theory_screens.dart';
import 'widgets/workout3_penny_screen.dart';

class Workout3Orchestrator extends ConsumerStatefulWidget {
  final String? initialSection;
  const Workout3Orchestrator({this.initialSection, super.key});
  @override
  ConsumerState<Workout3Orchestrator> createState() => _Workout3OrchestratorState();
}

class _Workout3OrchestratorState extends ConsumerState<Workout3Orchestrator> {
  late int step;
  @override
  void initState() {
    super.initState();
    step = _initialStep();
  }

  int _initialStep() {
    if (widget.initialSection == 'drills') return 9;
    if (widget.initialSection == 'skill_reps' || widget.initialSection == 'skill-reps') return 24;
    if (widget.initialSection == 'sr1') return 25;
    if (widget.initialSection == 'sr2') return 28;
    if (widget.initialSection == 'sr3') return 31;
    return 0;
  }

  void next() => setState(() => step++);
  void back() {
    if (step > _initialStep()) {
      setState(() => step--);
    } else {
      context.pop();
    }
  }

  void go(int s) => setState(() => step = s);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (d, r) {
        if (!d) back();
      },
      child: Scaffold(body: screen()),
    );
  }

  Widget screen() {
    switch (step) {
      case 0:
        return Workout3EntryScreen(onNext: next);
      case 1:
        return Workout3MainNarrationIntroScreen(onNext: next, onBack: back);
      case 2:
        return Workout3BodyBeforeMindScreen(onNext: next, onBack: back);
      case 3:
        return Workout3GoalScreen(onNext: next, onBack: back);
      case 4:
        return Workout3ModernTriggersScreen(onNext: next, onBack: back);
      case 5:
        return Workout3MisinterpretationLoopScreen(onNext: next, onBack: back);
      case 6:
        return Workout3ExampleCheckingScreen(onNext: next, onBack: back);
      case 7:
        return Workout3CoreMessageScreen(onNext: next, onBack: back);
      case 8:
        return Workout3TransitionToDrillsScreen(onNext: next, onBack: back);

      case 9:
        return Workout3Drill1EntryScreen(onNext: next, onBack: back);
      case 10:
        return Workout3Drill1PlayScreen(onComplete: next);
      case 11:
        return Workout3PennyScreen(
          lines: const ['The sensation came first.', 'Meaning arrived after.', 'You saw the split.'],
          repLabel: 'Sensation Separation',
          onNext: next,
        );

      case 12:
        return Workout3Drill2EntryScreen(onNext: next, onBack: back);
      case 13:
        return Workout3Drill2PlayScreen(onComplete: next);
      case 14:
        return Workout3PennyScreen(
          lines: const ['Activation is not regression.', 'A pattern fired.', 'You didn’t become it.'],
          repLabel: 'Sensation Separation',
          onNext: next,
        );

      case 15:
        return Workout3Drill3EntryScreen(onNext: next, onBack: back);
      case 16:
        return Workout3Drill3PlayScreen(onComplete: next);
      case 17:
        return Workout3PennyScreen(
          lines: const ['The sensation stayed.', 'You didn’t obey it.', 'That is how safety is learned.'],
          repLabel: 'Sensation Separation',
          onNext: next,
        );

      case 18:
        return Workout3DrillsCompleteScreen(onNext: next, onHome: () => context.go('/'));
      case 19:
        return Workout3MuscleSummaryScreen(onNext: next, onBack: back);
      case 20:
        return Workout3ClosingTransitionScreen(onNext: next, onBack: back);
      case 21:
        return Workout3ClosingCoreScreen(onNext: next, onBack: back);
      case 22:
        return Workout3ClosingInsightScreen(onNext: next, onBack: back);
      case 23:
        return Workout3ClosingForwardLookScreen(onNext: next, onBack: back);

      case 24:
        return Workout3NoticeScreen(line1: 'A sensation will appear.', line2: 'Heat… tension… movement.', onNext: next, onBack: back);
      case 25:
        return Workout3NoticeScreen(line1: 'Your system will treat it as important.', line2: 'Not because it is—but because it was felt.', onNext: next, onBack: back);
      case 26:
        return Workout3NoticeScreen(line1: 'The reaction will try to start here—', line2: 'checking… fixing… pulling away.', onNext: next, onBack: back);
      case 27:
        return Workout3NoticeScreen(line1: 'Nothing needs to change.', line2: 'This is where the body learns.', onNext: next, onBack: back);
      case 28:
        return Workout3NoticeScreen(line1: 'You won’t need to stop it.', line2: 'You’ll see it.', cta: '  Continue to Journal', onNext: () => go(29), onBack: back);

      case 29:
        return Workout3TrainingLogScreen(onNext: next, onSkip: () => go(31), onBack: back);
      case 30:
        return Workout3TrainingLogConfirmScreen(onContinue: next, onHome: () => context.go('/'));

      case 31:
        return Workout3SkillRepsEntryScreen(onNext: next, onBack: back);
      case 32:
        return Workout3SRIntroScreen(
          title: 'Create the Signal',
          body: 'Most fear begins with a sensation.\nToday, you will create one on purpose.',
          onStart: next,
          onSkip: () => go(35),
          onBack: back,
        );
      case 33:
        return Workout3SR1PlayScreen(onComplete: next);
      case 34:
        return Workout3PennyScreen(
          lines: const ['You created intensity.', 'Twice.', 'And it ended.', 'The sensation was never the threat.', 'The prediction was.'],
          repLabel: 'Sensation Separation',
          onNext: next,
        );

      case 35:
        return Workout3SRIntroScreen(
          title: 'Don’t Check',
          body: 'The loop grows when you monitor for danger.\nFor the next minute, do not check your body.',
          onStart: next,
          onSkip: () => go(38),
          onBack: back,
        );
      case 36:
        return Workout3SR2PlayScreen(onComplete: next);
      case 37:
        return Workout3PennyScreen(
          lines: const ['You weren’t responding to sensation.', 'You were responding to the urge to monitor.', 'You ignored the urge.', 'That’s strength.'],
          repLabel: 'Non-Reactivity',
          onNext: next,
        );

      case 38:
        return Workout3SRIntroScreen(
          title: 'The Interpretation Race',
          body: 'Notice what appears first.\nA word will flash briefly.',
          onStart: next,
          onSkip: () => go(41),
          onBack: back,
        );
      case 39:
        return Workout3SR3PlayScreen(onComplete: next);
      case 40:
        return Workout3PennyScreen(
          lines: const ['The word appeared.', 'The meaning appeared faster.', 'You didn’t react to sensation.', 'You reacted to prediction.', 'Fear begins before evidence.'],
          repLabel: 'Sensation Separation',
          onNext: next,
        );

      case 41:
        return Workout3SkillRepsCompleteScreen(onContinueWorkout4: () => context.go('/'), onHome: () => context.go('/'));
      default:
        return Scaffold(body: Center(child: Text('Step $step')));
    }
  }
}

