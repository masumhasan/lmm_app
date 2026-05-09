import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'drills/workout4_drill_screens.dart';
import 'reps/workout4_skill_reps_screens.dart';
import 'theory/workout4_theory_screens.dart';
import 'widgets/workout4_penny_screen.dart';

class Workout4Orchestrator extends ConsumerStatefulWidget {
  final String? initialSection;
  const Workout4Orchestrator({this.initialSection, super.key});
  @override
  ConsumerState<Workout4Orchestrator> createState() => _Workout4OrchestratorState();
}

class _Workout4OrchestratorState extends ConsumerState<Workout4Orchestrator> {
  late int step;
  @override
  void initState() {
    super.initState();
    step = _initialStep();
  }

  int _initialStep() {
    if (widget.initialSection == 'drills') return 13;
    if (widget.initialSection == 'skill_reps') return 27;
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
        return Workout4EntryScreen(onNext: next);
      case 1:
        return Workout4MainNarrationScreen(onNext: next, onBack: back);
      case 2:
        return Workout4CoreDefinitionScreen(onNext: next, onBack: back);
      case 3:
        return Workout4ProtectiveLogicScreen(onNext: next, onBack: back);
      case 4:
        return Workout4AttentionMistakeScreen(onNext: next, onBack: back);
      case 5:
        return Workout4NoiseBuildScreen(onNext: next, onBack: back);
      case 6:
        return Workout4ExamplesIntroScreen(onNext: next, onBack: back);
      case 7:
        return Workout4ExampleScreen(
          title: 'TEXT MESSAGE',
          lines: const ['“We need to talk.”', '“Call me later.”'],
          neutralClose: 'The mind creates 10 scenarios.\nNone have happened yet.',
          onNext: next,
          onBack: back,
        );
      case 8:
        return Workout4ExampleScreen(
          title: 'THE REPLAY',
          lines: const ['“I shouldn’t have said that.”', '“They must think I’m...”'],
          neutralClose: 'Revisiting the past\nwon’t change the outcome.',
          onNext: next,
          onBack: back,
        );
      case 9:
        return Workout4ExampleScreen(
          title: 'FUTURE SCANNING',
          lines: const ['“What if everything goes wrong?”', '“I need to be ready for...”'],
          neutralClose: 'Scanning for ghosts\nmakes them feel real.',
          onNext: next,
          onBack: back,
        );
      case 10:
        return Workout4WhyThinkingFailsScreen(onNext: next, onBack: back);
      case 11:
        return Workout4CoreShiftScreen(onNext: next, onBack: back);
      case 12:
        return Workout4TransitionToDrillsScreen(onNext: next, onBack: back);

      // Drill 1: Attention Control
      case 13:
        return Workout4Drill1EntryScreen(onNext: next, onBack: back);
      case 14:
        return Workout4Drill1PlayScreen(onComplete: next);
      case 15:
        return Workout4Drill1LockInScreen(onNext: next);
      case 16:
        return Workout4PennyScreen(
          lines: const ['You didn’t stop thoughts.', 'You removed fuel.', 'Noise runs on attention.'],
          repLabel: 'Attention Control',
          onNext: next,
        );

      // Drill 2: Urgency Resistance
      case 17:
        return Workout4Drill2EntryScreen(onNext: next, onBack: back);
      case 18:
        return Workout4Drill2PlayScreen(onComplete: next);
      case 19:
        return Workout4Drill2ResultScreen(onNext: next);
      case 20:
        return Workout4Drill2LockInScreen(onNext: next);
      case 21:
        return Workout4PennyScreen(
          lines: const ['Urgency promised consequences.', 'Nothing arrived.', 'Delay breaks authority.'],
          repLabel: 'Urgency Resistance',
          onNext: next,
        );

      // Drill 3: Completion Tolerance
      case 22:
        return Workout4Drill3EntryScreen(onNext: next, onBack: back);
      case 23:
        return Workout4Drill3PlayScreen(onComplete: next);
      case 24:
        return Workout4Drill3HoldScreen(onComplete: next);
      case 25:
        return Workout4Drill3ResultScreen(onNext: next);
      case 26:
        return Workout4Drill3LockInScreen(onNext: next);
      case 27:
        return Workout4PennyScreen(
          lines: const ['The thought stayed unfinished.', 'You didn’t complete it.', 'Nothing required an ending.'],
          repLabel: 'Completion Tolerance',
          onNext: next,
        );

      case 28:
        return Workout4DrillsCompleteScreen(onNext: next, onHome: () => context.go('/'));
      case 29:
        return Workout4MuscleSummaryScreen(onNext: next, onBack: back);
      case 30:
        return Workout4ClosingIntroScreen(onNext: next, onBack: back);
      case 31:
        return Workout4ClosingMainScreen(onNext: next, onBack: back);
      case 32:
        return Workout4ClosingInsightScreen(onNext: () => context.go('/hub'), onBack: back);

      default:
        return const Center(child: Text('Workout 4 End'));
    }
  }
}
