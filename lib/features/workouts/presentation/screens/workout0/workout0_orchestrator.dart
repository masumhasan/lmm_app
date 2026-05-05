import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'workout0_entry_screen.dart';
import 'theory/edu_screens.dart';
import 'theory/muscle_summary_screen.dart';
import 'drills/drill1_reflex_screen.dart';
import 'drills/drill2_urgency_screens.dart';
import 'drills/drill3_completion_screens.dart';
import 'widgets/workout0_penny_screen.dart';

import 'theory/closing_screens.dart';
import 'theory/journal_screens.dart';

import 'reps/skill_reps_screens.dart';
import 'reps/sr1_belief_bias.dart';
import 'reps/sr2_attention_pull.dart';
import 'reps/sr3_stay_shift.dart';

// Detailed Theory Phase Imports
import 'theory/system_screens.dart';
import 'theory/system_detailed_screens.dart';
import 'theory/pattern_screens.dart';

class Workout0Orchestrator extends ConsumerStatefulWidget {
  final String? initialSection;
  const Workout0Orchestrator({this.initialSection, super.key});

  @override
  ConsumerState<Workout0Orchestrator> createState() => _Workout0OrchestratorState();
}

class _Workout0OrchestratorState extends ConsumerState<Workout0Orchestrator> {
  late int currentStep;

  @override
  void initState() {
    super.initState();
    currentStep = _getInitialStep();
  }

  int _getInitialStep() {
    if (widget.initialSection == 'drills') return 5;
    if (widget.initialSection == 'skill_reps' || widget.initialSection == 'skill-reps') return 28;
    if (widget.initialSection == 'sr1') return 26;
    if (widget.initialSection == 'sr2') return 32;
    if (widget.initialSection == 'sr3') return 35;
    return 0;
  }

  void _onNext() {
    setState(() => currentStep++);
  }

  void _onBack() {
    if (currentStep > _getInitialStep()) {
      setState(() => currentStep--);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBack();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildCurrentScreen(),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (currentStep) {
      case 0:
        return Workout0EntryScreen(onNext: _onNext);
      case 1:
        return EduUntrainedScreen(onNext: _onNext, onBack: _onBack);
      // Detailed Theory Phase
      case 2:
        return SystemDetailedDefinitionScreen(onNext: _onNext, onBack: _onBack);
      case 3:
        return TrainingSystemRuleScreen(onNext: _onNext, onBack: _onBack);
      case 4:
        return PatternExample1Screen(onNext: _onNext, onBack: _onBack);

      // Drills Phase
      case 5:
        return Drill1EntryScreen(onNext: _onNext, onBack: _onBack);
      case 6:
        return Drill1ReflexScreen(onNext: _onNext, onBack: _onBack);
      case 7:
        return Drill1RevealScreen(onNext: _onNext, onBack: _onBack);
      case 8:
        return Workout0PennyScreen(
          text1: 'Most reactions are rehearsed.',
          text2: 'You just interrupted one.',
          repLoggedText: 'Attention Control',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 9:
        return Drill2EntryScreen(onNext: _onNext, onBack: _onBack);
      case 10:
        return Drill2CountdownScreen(onNext: _onNext);
      case 11:
        return Drill2RevealScreen(onNext: _onNext, onBack: _onBack);
      case 12:
        return Workout0PennyScreen(
          text1: 'Urgency is a sensation.',
          text2: 'Not a directive.',
          repLoggedText: 'Urgency Resistance',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 13:
        return Drill3EntryScreen(onNext: _onNext, onBack: _onBack);
      case 14:
        return Drill3IncompleteScreen(onNext: _onNext);
      case 15:
        return Drill3ReleaseScreen(onNext: _onNext, onBack: _onBack);
      case 16:
        return Workout0PennyScreen(
          text1: 'Your system preferred closure.',
          text2: 'You proved closure is optional.',
          repLoggedText: 'Completion Tolerance',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 17:
        return MuscleSummaryScreen(onNext: _onNext, onBack: _onBack);

      // Closing & Notice Phase
      case 18:
        return ClosingIntroScreen(onNext: _onNext, onBack: _onBack);
      case 19:
        return ClosingMainScreen(onNext: _onNext, onBack: _onBack);
      case 20:
        return NoticeScreen(
          line1: 'It will happen again today.',
          line2: 'Something will pull your attention.',
          onNext: _onNext,
          onBack: _onBack,
          hold1Ms: 1200,
          hold2Ms: 1400,
        );
      case 21:
        return NoticeScreen(
          line1: 'It will feel important.',
          line2: 'Nothing will actually require you.',
          onNext: _onNext,
          onBack: _onBack,
          hold1Ms: 1200,
          hold2Ms: 1500,
        );
      case 22:
        return NoticeScreen(
          line1: 'Your system will try to close it.',
          line2: 'You’ll see it this time.',
          onNext: _onNext,
          onBack: _onBack,
          hold1Ms: 1200,
          hold2Ms: 1600,
        );
      case 23:
        return JournalScreen(
          onNext: _onNext,
          onSkip: () => setState(() => currentStep = 25),
          onBack: _onBack,
        );
      case 24:
        return JournalConfirmScreen(
          onContinue: _onNext,
          onHome: () => context.pop(),
        );

      // Skill Reps Phase
      case 25:
        return SkillRepsEntryScreen(onNext: _onNext, onBack: _onBack);
      case 26:
        return SRIntroScreen(
          title: 'Which One Do You Believe?',
          subtext: 'All thoughts appear. Not all are believed.',
          instruction: 'Tap the one that feels more believable.',
          onStart: _onNext,
          onSkip: () => setState(() => currentStep = 32),
          onBack: _onBack,
        );
      case 27:
        return SR1BeliefBiasPlayScreen(onNext: _onNext);
      case 28:
        return SR1InsightScreen(onNext: _onNext, onBack: _onBack);
      case 29:
        return Workout0PennyScreen(
          text1: 'Belief wasn’t chosen logically.',
          text2: 'It felt familiar.',
          repLoggedText: 'Attention Control',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 30:
        return SRIntroScreen(
          title: 'The Pull',
          subtext: 'Attention moves before you decide.',
          instruction: 'Tap what pulled you first.',
          onStart: _onNext,
          onSkip: () => setState(() => currentStep = 36),
          onBack: _onBack,
        );
      case 31:
        return SR2AttentionPullPlayScreen(onNext: _onNext);
      case 32:
        return SR2InsightScreen(onNext: _onNext, onBack: _onBack);
      case 33:
        return Workout0PennyScreen(
          text1: 'You saw attention move first.',
          text2: 'That makes training possible.',
          repLoggedText: 'Attention Control',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 34:
        return SRIntroScreen(
          title: 'Stay or Shift',
          subtext: 'Where attention sits shapes experience.',
          instruction: 'Choose what you usually do.',
          onStart: _onNext,
          onSkip: () => setState(() => currentStep = 39),
          onBack: _onBack,
        );
      case 35:
        return SR3StayOrShiftPlayScreen(onNext: _onNext);
      case 36:
        return SR3InsightScreen(onNext: _onNext, onBack: _onBack);
      case 37:
        return Workout0PennyScreen(
          text1: 'You noticed your position.',
          text2: 'That creates distance.',
          repLoggedText: 'Completion Tolerance',
          onNext: _onNext,
          onBack: _onBack,
        );
      case 38:
        return WorkoutCompleteScreen(onHome: () => context.pop());
      
      default:
        return Scaffold(
          body: Center(child: Text('Step $currentStep')),
        );
    }
  }
}
