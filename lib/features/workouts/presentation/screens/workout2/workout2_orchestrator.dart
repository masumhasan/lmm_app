import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'drills/workout2_drill_screens.dart';
import 'reps/workout2_skill_rep_screens.dart';
import 'theory/workout2_journal_screens.dart';
import 'theory/workout2_theory_screens.dart';
import 'widgets/workout2_penny_screen.dart';

class Workout2Orchestrator extends ConsumerStatefulWidget {
  final String? initialSection;
  const Workout2Orchestrator({this.initialSection, super.key});
  @override
  ConsumerState<Workout2Orchestrator> createState() => _Workout2OrchestratorState();
}

class _Workout2OrchestratorState extends ConsumerState<Workout2Orchestrator> {
  late int currentStep;

  @override
  void initState() {
    super.initState();
    currentStep = _getInitialStep();
  }

  int _getInitialStep() {
    if (widget.initialSection == 'drills') return 13;
    if (widget.initialSection == 'skill_reps' || widget.initialSection == 'skill-reps') return 29;
    if (widget.initialSection == 'sr1') return 30;
    if (widget.initialSection == 'sr2') return 33;
    if (widget.initialSection == 'sr3') return 36;
    return 0;
  }

  void _onNext() => setState(() => currentStep++);
  void _onBack() {
    if (currentStep > _getInitialStep()) {
      setState(() => currentStep--);
    } else {
      context.pop();
    }
  }

  void _goStep(int step) => setState(() => currentStep = step);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _onBack();
      },
      child: Scaffold(backgroundColor: Colors.white, body: _buildCurrent()),
    );
  }

  Widget _buildCurrent() {
    switch (currentStep) {
      case 0:
        return Workout2EntryScreen(onNext: _onNext);
      case 1:
        return Workout2IntroNarrationScreen(onNext: _onNext, onBack: _onBack);
      case 2:
        return Workout2AlarmLoopDefinitionScreen(onNext: _onNext, onBack: _onBack);
      case 3:
        return Workout2AlarmLoopExplanationScreen(onNext: _onNext, onBack: _onBack);
      case 4:
        return Workout2ExampleScreen(
          title: 'The Heartbeat Loop',
          leftLines: const ['A sudden fast heartbeat.', 'Your body tenses.', 'Heart rate increases.'],
          rightLines: const ['"Something is wrong."', '"See? It\'s getting worse."'],
          realityLine: 'The heartbeat changed.\nThe system treated the change as proof.\nThat second interpretation fed the loop.',
          microLine: 'Training focus: separate sensation from the echo',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 5:
        return Workout2ExampleScreen(
          title: 'The Breath Loop',
          leftLines: const ['You notice your breathing.', 'Chest tightens.', 'Breath shortens.'],
          rightLines: const ['"Why is my breathing different?"', '"This is escalating."'],
          realityLine: 'Breath changed.\nThe reaction became evidence.\nThat is how the loop strengthened.',
          microLine: 'Training focus: spot the "proof" moment',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 6:
        return Workout2ExampleScreen(
          title: 'The Social Loop',
          leftLines: const ['You feel nervous before speaking.', 'Hands sweat.', 'Sensations increase.'],
          rightLines: const ['"You\'ll embarrass yourself."', '"You\'re losing control."'],
          realityLine: 'Nervousness appeared.\nThen the system sounded a second alarm about it.\nThat second alarm amplified the loop.',
          microLine: 'Training focus: catch the second alarm in real time',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 7:
        return Workout2ExampleScreen(
          title: 'The Avoidance Loop',
          leftLines: const ['You once felt alarm in a supermarket.', 'Your body tenses before entering.', 'The loop restarts.'],
          rightLines: const ['"Don\'t go back."'],
          realityLine: 'Avoidance marks the signal as important.\nNext time the alarm starts earlier.\nEarlier alarm means stronger loop.',
          microLine: 'Training focus: see how "avoid" teaches urgency',
          cta: '  Break It Down',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 8:
        return Workout2LoopIntroScreen(onNext: _onNext, onBack: _onBack);
      case 9:
        return Workout2LoopStepsScreen(onNext: _onNext, onBack: _onBack);
      case 10:
        return Workout2LoopPennyDropScreen(onNext: _onNext, onBack: _onBack);
      case 11:
        return Workout2ControlReturnsScreen(onNext: _onNext, onBack: _onBack);
      case 12:
        return Workout2FinalLockInScreen(onNext: _onNext, onBack: _onBack);

      case 13:
        return Workout2D1EntryScreen(onNext: _onNext, onBack: _onBack);
      case 14:
        return Workout2D1PlayScreen(onComplete: _onNext);
      case 15:
        return Workout2PennyScreen(
          lines: const [
            'The first alarm was simple.',
            'The second alarm repeated it.',
            'That repetition is fuel.',
          ],
          repLoggedText: 'Escalation Awareness',
          onNext: _onNext,
          minimumDisplayMs: 5000,
        );

      case 16:
        return Workout2D2EntryScreen(onNext: _onNext, onBack: _onBack);
      case 17:
        return Workout2D2PlayIntroScreen(onNext: _onNext);
      case 18:
        return Workout2D2PlayLoopScreen(onComplete: _onNext);
      case 19:
        return Workout2PennyScreen(
          lines: const [
            'The echo asked for fuel.',
            'You did not feed it.',
            'That is loop restraint.',
          ],
          repLoggedText: 'Loop Disruption',
          onNext: _onNext,
        );

      case 20:
        return Workout2D3EntryScreen(onNext: _onNext, onBack: _onBack);
      case 21:
        return Workout2D3PlayScreen(onComplete: _onNext);
      case 22:
        return Workout2PennyScreen(
          lines: const [
            'You found the growth point.',
            'Fear of sensation expands the loop.',
            'Interrupt there.',
          ],
          repLoggedText: 'Loop Disruption',
          onNext: _onNext,
        );

      case 23:
        return Workout2MuscleSummaryScreen(onNext: _onNext, onBack: _onBack);
      case 24:
        return Workout2ClosingTransitionScreen(onNext: _onNext, onBack: _onBack);
      case 25:
        return Workout2ClosingCoreScreen(onNext: _onNext, onBack: _onBack);

      case 26:
        return Workout2NoticeScreen(
          line1: 'Something will happen.',
          line2: 'Then something will respond to it.',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 27:
        return Workout2NoticeScreen(
          line1: 'It will feel like it\'s getting worse.',
          line2: 'Nothing new actually happened.',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 28:
        return Workout2NoticeScreen(
          line1: 'The loop will try to grow here',
          line2: 'when the reaction is treated as new.',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 29:
        return Workout2NoticeScreen(
          line1: 'You\'ll feel the pull to check… to control… to make it stop.',
          line2: 'That\'s what feeds it.',
          cta: '  Continue',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 30:
        return Workout2NoticeScreen(
          line1: 'You\'ll see it this time.',
          line2: '',
          cta: '  Continue to Journal',
          onNext: () => _goStep(31),
          onBack: _onBack,
        );

      case 31:
        return Workout2JournalScreen(
          onNext: _onNext,
          onSkip: () => _goStep(33),
          onBack: _onBack,
        );
      case 32:
        return Workout2JournalConfirmScreen(
          onContinue: _onNext,
          onHome: () => context.go('/'),
        );

      case 33:
        return Workout2SkillRepsEntryScreen(onNext: _onNext, onBack: _onBack);
      case 34:
        return Workout2SRIntroScreen(
          title: 'The Checking Trap',
          body: 'The loop survives because you keep checking if it\'s gone.\nDo not check the signal. Just watch it.',
          onStart: _onNext,
          onSkip: () => _goStep(37),
          onBack: _onBack,
        );
      case 35:
        return Workout2SR1PlayScreen(onComplete: _onNext);
      case 36:
        return Workout2PennyScreen(
          lines: const [
            'You were not checking danger.',
            'You were feeding relevance.',
            'No checking. No fuel.',
          ],
          repLoggedText: 'Escalation Awareness',
          onNext: _onNext,
          minimumDisplayMs: 4000,
        );

      case 37:
        return Workout2SRIntroScreen(
          title: 'The Control Rebound',
          body: 'Try to control the signal.\nDrag it down to zero.',
          onStart: _onNext,
          onSkip: () => _goStep(40),
          onBack: _onBack,
        );
      case 38:
        return Workout2SR2PlayScreen(onComplete: _onNext);
      case 39:
        return Workout2PennyScreen(
          lines: const [
            'Force created rebound.',
            'Non-interference reduced momentum.',
            'Control was the extra fuel.',
          ],
          repLoggedText: 'Loop Disruption',
          onNext: _onNext,
        );

      case 40:
        return Workout2SRIntroScreen(
          title: 'The Escape Reflex',
          body: 'The loop grows when you try to escape the signal.\nDo not respond to the urge.',
          onStart: _onNext,
          onSkip: () => _goStep(43),
          onBack: _onBack,
        );
      case 41:
        return Workout2SR3PlayScreen(onComplete: _onNext);
      case 42:
        return Workout2PennyScreen(
          lines: const [
            'You were not trapped by the sensation.',
            'You were pulled by the escape reflex.',
            'No response. Less loop.',
          ],
          repLoggedText: 'Loop Disruption',
          onNext: _onNext,
          minimumDisplayMs: 5000,
        );

      case 43:
        return Workout2SkillRepsCompleteScreen(
          onContinueWorkout3: () => context.go('/workouts/3/play'),
          onHome: () => context.go('/'),
        );

      default:
        return Scaffold(body: Center(child: Text('Step $currentStep')));
    }
  }
}

