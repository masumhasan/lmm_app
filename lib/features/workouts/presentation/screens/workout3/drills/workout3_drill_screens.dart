import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import '../widgets/workout3_content_layout.dart';

class Workout3Drill1EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3Drill1EntryScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      showHome: false,
      nextButtonText: '  Start Drill',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Split the Stack', style: AppTypography.h1.copyWith(fontSize: 34), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text('Sensation.\nMeaning.\nIdentity.\nThey feel instant.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text('They are not.', style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout3Drill1PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout3Drill1PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout3Drill1PlayScreen> createState() => _Workout3Drill1PlayScreenState();
}

class _Workout3Drill1PlayScreenState extends State<Workout3Drill1PlayScreen> {
  int q = 0;
  bool _showClose = false;
  final questions = const [
    ('Your heart rate jumps.\nWhat appears next automatically?', ['That is a sensation', 'Something is wrong', 'I am going backwards'], 1),
    ('Chest tightness.\nWhat fires first?', ['Danger', 'Pressure', 'This is happening again'], 0),
    ('Warm face.\nWhat fires first?', ['Embarrassment', 'Heat', 'I am losing control'], 0),
    ('Shallow breath.\nWhat fires first?', ['Danger', 'Air moving', 'It is happening again'], 0),
  ];
  String? feedback;

  static const _correctFeedback = [
    'That is where meaning enters.',
    'Meaning fires fast.',
    'Interpretation arrives before identity.',
    'The stack builds one layer at a time.',
  ];

  void answer(int i) {
    final correct = questions[q].$3;
    if (i == correct) {
      setState(() => feedback = _correctFeedback[q]);
      Future.delayed(const Duration(milliseconds: 800), () {
        if (!mounted) return;
        if (q == questions.length - 1) {
          setState(() => _showClose = true);
          Future.delayed(const Duration(milliseconds: 2200), () {
            if (mounted) widget.onComplete();
          });
        } else {
          setState(() {
            q++;
            feedback = null;
          });
        }
      });
    } else {
      setState(() => feedback = 'Retry');
      Future.delayed(const Duration(milliseconds: 600), () => mounted ? setState(() => feedback = null) : null);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showClose) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('You split the stack.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text('Sensation was one event.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text('What followed was added.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
    }
    final qq = questions[q];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(qq.$1, style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
              const SizedBox(height: 20),
              for (int i = 0; i < qq.$2.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent.withOpacity(0.08), foregroundColor: AppColors.ink, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), minimumSize: const Size.fromHeight(48)),
                    onPressed: () => answer(i),
                    child: Text(qq.$2[i], style: AppTypography.p.copyWith(fontSize: 14)),
                  ),
                ),
              if (feedback != null) ...[
                const SizedBox(height: 8),
                Text(feedback!, style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.35))),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class Workout3Drill2EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3Drill2EntryScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      showHome: false,
      nextButtonText: '  Start',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Break the Collapse', style: AppTypography.h1.copyWith(fontSize: 33), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text('Patterns firing does not erase progress.', style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.45))),
        ],
      ),
    );
  }
}

class Workout3Drill2PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout3Drill2PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout3Drill2PlayScreen> createState() => _Workout3Drill2PlayScreenState();
}

class _Workout3Drill2PlayScreenState extends State<Workout3Drill2PlayScreen> {
  int step = 0;
  bool _showClose = false;

  @override
  Widget build(BuildContext context) {
    if (_showClose) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Progress did not collapse.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text('A pattern fired.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text('Those are not the same.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
    }
    final prompts = [
      ('You felt steady.\nThen a strong sensation appeared.\nWhat does the mind say?', ['The past reactivated', 'A body signal appeared', 'I failed'], 1),
      ('Sensation appears after calm week.', ['Pattern firing', 'Progress erased'], 0),
      ('Strong sensation after a good month.', ['Regression', 'Temporary activation'], 1),
      ('Old memory triggered by body signal.', ['I am back', 'Association activated'], 1),
      ('Unexpected intensity during rest.', ['Something broke', 'Body fluctuation'], 1),
    ];
    final p = prompts[step];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(p.$1, style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
              const SizedBox(height: 18),
              for (int i = 0; i < p.$2.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent.withOpacity(0.08), foregroundColor: AppColors.ink, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), minimumSize: const Size.fromHeight(48)),
                    onPressed: () {
                      if (i == p.$3) {
                        if (step == prompts.length - 1) {
                          setState(() => _showClose = true);
                          Future.delayed(const Duration(milliseconds: 2200), () {
                            if (mounted) widget.onComplete();
                          });
                        } else {
                          setState(() => step++);
                        }
                      }
                    },
                    child: Text(p.$2[i], style: AppTypography.p.copyWith(fontSize: 14)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Workout3Drill3EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3Drill3EntryScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onNext,
      onBack: onBack,
      showHome: false,
      nextButtonText: '  Start',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Hold the Signal', style: AppTypography.h1.copyWith(fontSize: 34)),
          const SizedBox(height: 10),
          Text('When sensation appears, the body waits for instruction.', style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout3Drill3PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout3Drill3PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout3Drill3PlayScreen> createState() => _Workout3Drill3PlayScreenState();
}

class _Workout3Drill3PlayScreenState extends State<Workout3Drill3PlayScreen> {
  int round = 1;
  int secs = 10;
  Timer? t;
  String? micro;
  bool _showClose = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() {
    t?.cancel();
    secs = round == 1 ? 10 : 15;
    t = Timer.periodic(const Duration(seconds: 1), (tt) {
      if (!mounted) return;
      setState(() => secs--);
      if (secs <= 0) {
        tt.cancel();
        if (round == 1) {
          setState(() {
            round = 2;
            micro = 'No action is also an action.';
          });
          Future.delayed(const Duration(milliseconds: 700), () => mounted ? _start() : null);
        } else {
          setState(() => _showClose = true);
          Future.delayed(const Duration(milliseconds: 2200), () {
            if (mounted) widget.onComplete();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    t?.cancel();
    super.dispose();
  }

  void _tapAction(String type) {
    setState(() => micro = type == 'fix' ? 'Reaction reinforces the pattern.' : 'Monitoring keeps the loop active.');
    _start();
  }

  @override
  Widget build(BuildContext context) {
    if (_showClose) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('The sensation stayed.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text('Reaction did not.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text('That is where safety is learned.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (round == 1)
                Text('Stay with a mild sensation.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center)
              else
                Column(
                  children: [
                    Text('Stay again.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
                    const SizedBox(height: 6),
                    Text('Do not help it.', style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5)), textAlign: TextAlign.center),
                    const SizedBox(height: 4),
                    Text('Do not fix it.', style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5)), textAlign: TextAlign.center),
                  ],
                ),
              const SizedBox(height: 10),
              Text('$secs', style: AppTypography.h1.copyWith(fontSize: 270, color: AppColors.ink.withOpacity(0.25))),
              const SizedBox(height: 34),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: OutlinedButton(
                        onPressed: () => _tapAction('fix'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 75),
                        ),
                        child: const Text('Fix', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 3,
                      child: OutlinedButton(
                        onPressed: () => _tapAction('check'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 75),
                        ),
                        child: const Text('Check', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: () => setState(() => micro = 'That is instruction.'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 75),
                        ),
                        child: const Text('Leave It',
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ),
              if (micro != null) ...[
                const SizedBox(height: 12),
                Text(micro!, style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

