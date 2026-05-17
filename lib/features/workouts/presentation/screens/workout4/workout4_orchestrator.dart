import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'closing/workout4_journal_screens.dart';
import 'closing/workout4_notice_screens.dart';
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
    if (widget.initialSection == 'skill_reps') return 41;
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
          lines: const ['You did not stop the thought.', 'You removed its fuel.', 'Noise runs on attention.'],
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
          lines: const ['Urgency made a promise.', 'Nothing arrived.', 'Delay broke its authority.'],
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
          lines: const ['The thought stayed unfinished.', 'You did not complete it.', 'Nothing required an ending.'],
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
        return Workout4ClosingInsightScreen(onNext: next, onBack: back);

      // Notice Layer
      case 33:
        return Workout4Notice1Screen(onNext: next, onBack: back);
      case 34:
        return Workout4Notice2Screen(onNext: next, onBack: back);
      case 35:
        return Workout4Notice3Screen(onNext: next, onBack: back);
      case 36:
        return Workout4Notice4Screen(onNext: next, onBack: back);
      case 37:
        return Workout4Notice5Screen(onNext: next, onBack: back);

      // Journal
      case 38:
        return Workout4JournalIntroScreen(onNext: next, onBack: back);
      case 39:
        return Workout4JournalPromptScreen(onNext: next, onSkip: next, onBack: back);
      case 40:
        return Workout4JournalConfirmScreen(onContinue: next, onHome: () => context.go('/'));

      // Skill Reps Entry
      case 41:
        return Workout4SkillRepsEntryScreen(
          onNext: next, onBack: back, onSkip: () => context.go('/hub'));

      // SR1 — Noise or Signal?
      case 42:
        return Workout4SR1IntroScreen(onNext: next, onBack: back);
      case 43:
        return Workout4SR1PlayScreen(onComplete: next);
      case 44:
        return Workout4SR1InsightScreen(onNext: next, onBack: back);
      case 45:
        return Workout4PennyScreen(
          lines: const ['Noise pushed.', 'Signal reported.', 'You separated the two.'],
          repLabel: 'Noise or Signal',
          onNext: next,
        );

      // SR2 — Interrupt Without Solving
      case 46:
        return Workout4SR2IntroScreen(onNext: next, onBack: back);
      case 47:
        return Workout4SR2PlayScreen(onComplete: next);
      case 48:
        return Workout4PennyScreen(
          lines: const ['You interrupted the noise.', 'You did not answer it.', 'That is control.'],
          repLabel: 'Interrupt Without Solving',
          onNext: next,
        );

      // SR3 — Step Back
      case 49:
        return Workout4SR3IntroScreen(onNext: next, onBack: back);
      case 50:
        return Workout4SR3PlayScreen(onComplete: next);
      case 51:
        return Workout4PennyScreen(
          lines: const ['You did not change the thought.', 'You changed position.', 'That is why it lost authority.'],
          repLabel: 'Step Back',
          onNext: next,
        );

      // Skill Reps Complete
      case 52:
        return Workout4SkillRepsCompleteScreen(
          onHub: () => context.go('/hub'),
          onHome: () => context.go('/'),
        );

      default:
        return const Center(child: Text('Workout 4 End'));
    }
  }
}
