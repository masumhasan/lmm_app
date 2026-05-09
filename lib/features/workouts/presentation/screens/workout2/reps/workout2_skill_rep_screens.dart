import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import '../widgets/workout2_content_layout.dart';

class Workout2SkillRepsEntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2SkillRepsEntryScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: 'Start Skill Reps',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: DotLottieLoader.fromAsset(
              'assets/lotties/game.lottie',
              frameBuilder: (BuildContext context, DotLottie? lottie) {
                if (lottie != null) {
                  return Lottie.memory(lottie.animations.values.single);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          const SizedBox(height: 24),
          Text('Skill Reps', style: AppTypography.h1.copyWith(fontSize: 34)),
          const SizedBox(height: 10),
          Text('3 short reps. No scoring. No feedback. Just training.', style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout2SRIntroScreen extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onStart;
  final VoidCallback onSkip;
  final VoidCallback onBack;
  const Workout2SRIntroScreen({
    required this.title,
    required this.body,
    required this.onStart,
    required this.onSkip,
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onStart,
      onBack: onBack,
      showHome: false,
      nextButtonText: 'Start',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTypography.h1.copyWith(fontSize: 32), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(body, style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
          const SizedBox(height: 18),
          TextButton(onPressed: onSkip, child: Text('Skip', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3)))),
        ],
      ),
    );
  }
}

class Workout2SR1PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout2SR1PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout2SR1PlayScreen> createState() => _Workout2SR1PlayScreenState();
}

class _Workout2SR1PlayScreenState extends State<Workout2SR1PlayScreen> {
  String status = 'Stable';
  bool tapped = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () => mounted ? setState(() => status = 'Slightly Elevated') : null);
    Future.delayed(const Duration(seconds: 12), () => mounted && !tapped ? setState(() => status = 'Stable') : null);
    Future.delayed(const Duration(seconds: 20), () => mounted ? widget.onComplete() : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Do not tap the signal.', style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.35))),
            const SizedBox(height: 14),
            Text('Signal Status: $status', style: AppTypography.h2.copyWith(fontSize: 26)),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: tapped
                  ? null
                  : () {
                      setState(() {
                        tapped = true;
                        status = 'Elevated';
                      });
                    },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                width: tapped ? 36 : 16,
                height: tapped ? 36 : 16,
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.accent.withOpacity(tapped ? 0.85 : 0.55)),
              ),
            ),
            if (tapped) ...[
              const SizedBox(height: 10),
              Text('Checking feeds it.', style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.42))),
            ],
          ],
        ),
      ),
    );
  }
}

class Workout2SR2PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout2SR2PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout2SR2PlayScreen> createState() => _Workout2SR2PlayScreenState();
}

class _Workout2SR2PlayScreenState extends State<Workout2SR2PlayScreen> {
  double v = 60.0;
  int rebounds = 0;
  bool passive = false;
  bool _isRebounding = false;
  Timer? _idleTimer;
  Timer? _dropTimer;

  void _scheduleIdle() {
    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) _startDrop();
    });
  }

  void _startDrop() {
    if (passive) return;
    passive = true;
    _dropTimer = Timer.periodic(const Duration(milliseconds: 120), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() => v = (v - 1.1).clamp(30, 100));
      if (v <= 30.1) {
        t.cancel();
        Future.delayed(const Duration(seconds: 2), () => mounted ? widget.onComplete() : null);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scheduleIdle();
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    _dropTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(rebounds >= 3 ? 'Stop adjusting.' : 'Drag it down to zero.', style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.35))),
              const SizedBox(height: 18),
              Text('Signal Level', style: AppTypography.columnHeader.copyWith(fontSize: 10)),
              Text(v.round().toString(), style: AppTypography.h1.copyWith(fontSize: 46)),
              Slider(
                value: v,
                min: 0,
                max: 100,
                onChanged: passive
                    ? null
                    : (val) {
                        setState(() => v = val);
                        _scheduleIdle();
                        if (val < 40 && rebounds < 3 && !_isRebounding) {
                          _isRebounding = true;
                          Future.delayed(const Duration(milliseconds: 500), () {
                            if (!mounted) return;
                            setState(() {
                              rebounds++;
                              v = (75.0 + (rebounds * 5)).clamp(0.0, 100.0);
                              _isRebounding = false;
                            });
                            if (rebounds >= 3) _scheduleIdle();
                          });
                        }
                      },
              ),
              if (rebounds > 0 && rebounds < 3) Text('Forcing control creates resistance.', style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.45))),
              if (rebounds == 0) Text('Control is not required.', style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.3))),
            ],
          ),
        ),
      ),
    );
  }
}

class Workout2SR3PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout2SR3PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout2SR3PlayScreen> createState() => _Workout2SR3PlayScreenState();
}

class _Workout2SR3PlayScreenState extends State<Workout2SR3PlayScreen> {
  int phase = 1;
  bool tapped = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () => mounted ? setState(() => phase = 2) : null);
    Future.delayed(const Duration(seconds: 14), () => mounted ? setState(() => phase = 3) : null);
    Future.delayed(const Duration(seconds: 22), () => mounted ? setState(() => phase = 4) : null);
    Future.delayed(const Duration(seconds: 32), () => mounted ? widget.onComplete() : null);
  }

  @override
  Widget build(BuildContext context) {
    final lines = [
      'Make it stop.',
      'This shouldn’t be here.',
      'What if this doesn’t pass?',
      'Do something.',
      if (phase >= 3) 'Waiting feels wrong.',
    ];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => tapped = true),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Sensation Present.', style: AppTypography.h1.copyWith(fontSize: 40), textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text('No action required.', style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.3))),
                const SizedBox(height: 30),
                if (phase >= 2)
                  for (final line in lines)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(line, style: AppTypography.p.copyWith(fontSize: 17, color: AppColors.ink.withOpacity(phase >= 3 ? 0.7 : 0.45), fontStyle: FontStyle.italic)),
                    ),
                if (phase >= 4) ...[
                  const SizedBox(height: 12),
                  Text('Sensation Passing.', style: AppTypography.h2.copyWith(fontSize: 30, color: AppColors.accent)),
                ],
                if (tapped) ...[
                  const SizedBox(height: 12),
                  Text('That was the escape reflex.', style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.4))),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Workout2SkillRepsCompleteScreen extends StatelessWidget {
  final VoidCallback onContinueWorkout3;
  final VoidCallback onHome;
  const Workout2SkillRepsCompleteScreen({required this.onContinueWorkout3, required this.onHome, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'The alarm felt endless\nbecause you could not see the loop.\n\nYou saw checking.\nYou saw control.\nYou saw the escape reflex.\n\nThe loop does not grow from sensation.\nIt grows from reaction to sensation.',
                style: AppTypography.h2.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text('Set Complete: Skill Reps\nYou trained: no checking · no forcing · no escape', style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
              const SizedBox(height: 28),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 15)),
                onPressed: onContinueWorkout3,
                child: Text('Continue to Workout 3', style: AppTypography.btnText.copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), side: BorderSide(color: AppColors.line.withOpacity(0.8)), padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 15)),
                onPressed: () => context.go('/hub'),
                child: Text('Explore Tools Hub', style: AppTypography.btnText.copyWith(color: AppColors.ink.withOpacity(0.6))),
              ),
              const SizedBox(height: 10),
              TextButton(onPressed: onHome, child: Text('Return to Home', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.35)))),
            ],
          ),
        ),
      ),
    );
  }
}

