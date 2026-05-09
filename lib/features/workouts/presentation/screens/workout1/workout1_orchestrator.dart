import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'workout1_entry_screen.dart';

// Theory / Education
import 'theory/education_screens.dart';
import 'theory/examples_screens.dart';
import 'theory/evidence_screens.dart';
import 'theory/muscle_summary_screen.dart';
import 'theory/closing_screens.dart';
import 'theory/journal_screens.dart';

// Drills
import 'drills/workout1_d1_intro_screen.dart';
import 'drills/workout1_d1_play_screen.dart';
import 'drills/workout1_d2_screens.dart';
import 'drills/workout1_d3_screens.dart';

// Widgets
import 'widgets/workout1_penny_screen.dart';

// Skill Reps
import 'reps/workout1_skill_reps_entry_screen.dart';
import 'reps/workout1_sr1_attention_lane.dart';
import 'reps/workout1_sr2_certainty_dial.dart';
import 'reps/workout1_sr3_concrete_sort.dart';
import 'reps/workout1_sr_complete_screen.dart';

// Coach Preview
import 'coach/workout1_coach_screens.dart';

// Library
import 'library/workout1_library_screens.dart';

class Workout1Orchestrator extends ConsumerStatefulWidget {
  final String? initialSection;
  const Workout1Orchestrator({this.initialSection, super.key});

  @override
  ConsumerState<Workout1Orchestrator> createState() => _Workout1OrchestratorState();
}

class _Workout1OrchestratorState extends ConsumerState<Workout1Orchestrator> {
  late int currentStep;

  // Drill 1 tap result for conditional penny text
  D1TapResult _d1Result = D1TapResult.noTaps;

  // Coach preview sub-navigation
  int? _coachCardIndex;
  bool _inCoachFlow = false;
  int _coachStep = 0;

  // Library sub-navigation
  bool _inLibraryFlow = false;
  int? _libraryCardIndex;

  @override
  void initState() {
    super.initState();
    currentStep = _getInitialStep();
  }

  // ─── Section entry points ───
  static const _stepDrills = 13;
  static const _stepSkillReps = 30;
  static const _stepSR1 = 31;
  static const _stepSR2 = 34;
  static const _stepSR3 = 37;

  int _getInitialStep() {
    switch (widget.initialSection) {
      case 'drills':
        return _stepDrills;
      case 'skill_reps':
      case 'skill-reps':
        return _stepSkillReps;
      case 'sr1':
        return _stepSR1;
      case 'sr2':
        return _stepSR2;
      case 'sr3':
        return _stepSR3;
      default:
        return 0;
    }
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

  void _goToStep(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _onBack();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _inCoachFlow
            ? _buildCoachFlow()
            : _inLibraryFlow
                ? _buildLibraryFlow()
                : _buildCurrentScreen(),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  //  MAIN WORKOUT FLOW
  // ═══════════════════════════════════════════════════════════
  Widget _buildCurrentScreen() {
    switch (currentStep) {
      // ── Theory / Education Phase ──────────────────────────
      case 0:
        return Workout1EntryScreen(onNext: _onNext);

      case 1:
        return Workout1EducationIntroScreen(onNext: _onNext, onBack: _onBack);

      case 2:
        return Workout1StoryCoreScreen(onNext: _onNext, onBack: _onBack);

      // Workout1_Stories_Title removed per CHANGES doc
      case 3:
        return Workout1WhyStoriesScreen(onNext: _onNext, onBack: _onBack);

      case 4:
        return Workout1ReframeScreen(onNext: _onNext, onBack: _onBack);

      case 5:
        return Workout1ExamplesIntroScreen(onNext: _onNext, onBack: _onBack);

      case 6:
        return Workout1ExamplePartyScreen(onNext: _onNext, onBack: _onBack);

      case 7:
        return Workout1ExampleHealthScreen(onNext: _onNext, onBack: _onBack);

      case 8:
        return Workout1ExampleRelationshipScreen(onNext: _onNext, onBack: _onBack);

      case 9:
        return Workout1ExamplePastTagScreen(onNext: _onNext, onBack: _onBack);

      case 10:
        return Workout1EvidenceTitleScreen(onNext: _onNext, onBack: _onBack);

      case 11:
        return Workout1EvidenceRuleScreen(onNext: _onNext, onBack: _onBack);

      case 12:
        return Workout1TransitionToDrillsScreen(onNext: _onNext, onBack: _onBack);

      // ── Drill 1: Snap Detection ──────────────────────────
      case 13:
        return Workout1D1IntroScreen(onNext: _onNext, onBack: _onBack);

      case 14:
        return Workout1D1PlayScreen(
          onComplete: (result) {
            _d1Result = result;
            _onNext();
          },
        );

      case 15:
        return Workout1PennyScreen(
          lines: _d1PennyLines(),
          repLoggedText: 'Pattern Recognition',
          onNext: _onNext,
          onBack: _onBack,
        );

      // ── Drill 2: Distortion Under Pressure ───────────────
      case 16:
        return Workout1D2IntroScreen(onNext: _onNext, onBack: _onBack);

      case 17:
        return Workout1D2PlayScreen(onComplete: _onNext);

      case 18:
        return Workout1PennyScreen(
          lines: const [
            'Intensity rises when interpretation compounds.',
            'You interrupted the build.',
          ],
          repLoggedText: 'Story Separation',
          onNext: _onNext,
          onBack: _onBack,
        );

      // ── Drill 3: Author Shift ─────────────────────────────
      case 19:
        return Workout1D3Play1Screen(onNext: _onNext);

      case 20:
        return Workout1D3Play2Screen(onNext: _onNext);

      case 21:
        return Workout1PennyScreen(
          lines: const [
            'The sentence stayed the same.',
            'Your position changed.',
            'That shift is separation.',
          ],
          repLoggedText: 'Story Separation',
          onNext: _onNext,
          onBack: _onBack,
        );

      // ── Muscle Summary ────────────────────────────────────
      case 22:
        return Workout1MuscleSummaryScreen(onNext: _onNext, onBack: _onBack);

      // ── Closing ───────────────────────────────────────────
      case 23:
        return Workout1ClosingIntroScreen(onNext: _onNext, onBack: _onBack);

      case 24:
        return Workout1ClosingMessageScreen(onNext: _onNext, onBack: _onBack);

      // Workout1_Closing_Forward removed from active flow per CHANGES doc
      // Route directly to Notice Layer

      // ── Notice Layer ──────────────────────────────────────
      case 25:
        return Workout1Notice1Screen(onNext: _onNext, onBack: _onBack);

      case 26:
        return Workout1Notice2Screen(onNext: _onNext, onBack: _onBack);

      case 27:
        return Workout1Notice3Screen(onNext: _onNext, onBack: _onBack);

      // ── Journal ───────────────────────────────────────────
      case 28:
        return Workout1JournalScreen(
          onNext: _onNext,
          onSkip: () => _goToStep(30),
          onBack: _onBack,
        );

      case 29:
        return Workout1JournalConfirmScreen(
          onContinue: _onNext,
          onHome: () => context.go('/'),
        );

      // ── Skill Reps ────────────────────────────────────────
      case 30:
        return Workout1SkillRepsEntryScreen(onNext: _onNext, onBack: _onBack);

      // SR1 — Attention Lane
      case 31:
        return Workout1SRIntroScreen(
          title: 'Attention Lane',
          body1: 'Stories try to pull attention away.',
          body2: 'Stay steady.',
          onStart: _onNext,
          onSkip: () => _goToStep(34),
          onBack: _onBack,
        );

      case 32:
        return Workout1SR1PlayScreen(onComplete: _onNext);

      case 33:
        return Workout1PennyScreen(
          lines: const [
            'The story tried to pull you.',
            "You didn't remove it.",
            'You stayed with what was real.',
            "Control isn't silence.",
            "It's steadiness under interference.",
          ],
          repLoggedText: 'Story Separation',
          minimumDisplayMs: 4000,
          onNext: _onNext,
          onBack: _onBack,
        );

      // SR2 — Certainty Dial
      case 34:
        return Workout1SRIntroScreen(
          title: 'Certainty Dial',
          body1: 'The system rushes to certainty.',
          body2: 'Reality is often unclear.',
          onStart: _onNext,
          onSkip: () => _goToStep(37),
          onBack: _onBack,
        );

      case 35:
        return Workout1SR2PlayScreen(onComplete: _onNext);

      case 36:
        return Workout1PennyScreen(
          lines: const [
            'The system rushed toward certainty.',
            'Reality stayed unclear.',
            'You held neutral',
            'without forcing an answer.',
          ],
          repLoggedText: 'Pattern Recognition',
          minimumDisplayMs: 4000,
          onNext: _onNext,
          onBack: _onBack,
        );

      // SR3 — Concrete Sort
      case 37:
        return Workout1SRIntroScreen(
          title: 'Concrete Sort',
          body1: 'Stories feel urgent.',
          body2: 'Concrete moves you forward.',
          onStart: _onNext,
          onSkip: () => _goToStep(40),
          onBack: _onBack,
        );

      case 38:
        return Workout1SR3PlayScreen(onComplete: _onNext);

      case 39:
        return Workout1PennyScreen(
          lines: const [
            'Stories feel loud.',
            'Concrete feels simple.',
            'You chose action',
            'over assumption.',
          ],
          repLoggedText: 'Story Separation',
          minimumDisplayMs: 4000,
          onNext: _onNext,
          onBack: _onBack,
        );

      // ── Final Completion ──────────────────────────────────
      case 40:
        return Workout1SRCompleteScreen(
          onContinueToWorkout2: () => context.go('/workouts/2/play'),
          onCoachPreview: () => setState(() {
            _inCoachFlow = true;
            _coachStep = 0;
          }),
          onHome: () => context.go('/'),
        );

      default:
        return Scaffold(body: Center(child: Text('Step $currentStep')));
    }
  }

  // ─── D1 conditional penny text ────────────────────────────
  List<String> _d1PennyLines() {
    switch (_d1Result) {
      case D1TapResult.earlyInterpretation:
        return ['You caught the moment meaning entered.'];
      case D1TapResult.strongInterpretation:
        return ['You caught the stronger interpretation.'];
      case D1TapResult.noTaps:
      case D1TapResult.none:
        return [
          'Stories feel seamless.',
          'Until you slow them down.',
          'Detection is separation.',
        ];
    }
  }

  // ═══════════════════════════════════════════════════════════
  //  COACH PREVIEW SUB-FLOW
  // ═══════════════════════════════════════════════════════════
  Widget _buildCoachFlow() {
    switch (_coachStep) {
      case 0:
        return Workout1CoachDisclaimerScreen(
          onNext: () => setState(() => _coachStep = 1),
        );
      case 1:
        return Workout1CoachIntroScreen(
          onNext: () => setState(() => _coachStep = 2),
          onBack: () => setState(() {
            _inCoachFlow = false;
            _coachStep = 0;
          }),
        );
      case 2:
        return Workout1CoachCardsScreen(
          onCardTap: (index) => setState(() {
            _coachCardIndex = index;
            _coachStep = 3;
          }),
          onBack: () => setState(() => _coachStep = 1),
        );
      case 3:
        return Workout1CoachResponseScreen(
          cardIndex: _coachCardIndex ?? 0,
          onBack: () => setState(() => _coachStep = 2),
          onContinue: () => setState(() => _coachStep = 4),
        );
      case 4:
        return Workout1CoachEndScreen(
          onHome: () => setState(() {
            _inCoachFlow = false;
            _coachStep = 0;
          }),
        );
      default:
        return const Scaffold(body: Center(child: Text('Coach')));
    }
  }

  // ═══════════════════════════════════════════════════════════
  //  LIBRARY SUB-FLOW
  // ═══════════════════════════════════════════════════════════
  Widget _buildLibraryFlow() {
    if (_libraryCardIndex != null) {
      return Workout1LibraryDetailScreen(
        cardIndex: _libraryCardIndex!,
        onBack: () => setState(() => _libraryCardIndex = null),
      );
    }
    return Workout1LibraryMenuScreen(
      onCardTap: (index) => setState(() => _libraryCardIndex = index),
      onBack: () => setState(() {
        _inLibraryFlow = false;
        _libraryCardIndex = null;
      }),
    );
  }
}
