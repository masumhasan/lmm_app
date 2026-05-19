import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:animate_do/animate_do.dart';
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
  const Workout2SkillRepsCompleteScreen(
      {required this.onContinueWorkout3, required this.onHome, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.2),
                  radius: 1.2,
                  colors: [
                    AppColors.accent.withOpacity(0.03),
                    Colors.transparent
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeInUp(
                    child: Column(
                      children: [
                        Text(
                          'WORKOUT 2',
                          style: AppTypography.columnHeader.copyWith(
                            fontSize: 10,
                            letterSpacing: 4.0,
                            color: AppColors.ink.withOpacity(0.25),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Training Complete',
                          style: AppTypography.h1.copyWith(
                              fontSize: 34,
                              fontStyle: FontStyle.italic,
                              height: 1.1),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  FadeIn(
                    delay: const Duration(milliseconds: 400),
                    child: Column(
                      children: [
                        Text(
                          'The alarm felt endless\nbecause you could not see the loop.',
                          style: AppTypography.p.copyWith(
                            fontSize: 16,
                            color: AppColors.ink.withOpacity(0.6),
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'You saw checking.\nYou saw control.\nYou saw the escape reflex.',
                          style: AppTypography.p.copyWith(
                            fontSize: 16,
                            color: AppColors.ink.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'The loop does not grow from sensation.\nIt grows from reaction to sensation.',
                          style: AppTypography.h2.copyWith(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: AppColors.ink.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: Text(
                      'Set Complete: Skill Reps\nYou trained: no checking · no forcing · no escape',
                      style: AppTypography.columnHeader.copyWith(
                        fontSize: 9,
                        color: AppColors.ink.withOpacity(0.3),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 48),
                  FadeInUp(
                    delay: const Duration(milliseconds: 800),
                    child: _CompletionAction(
                      label: 'CONTINUE TRAINING',
                      subLabel: 'Workout 3',
                      icon: LucideIcons.arrowRight,
                      isPrimary: true,
                      onTap: onContinueWorkout3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeInUp(
                    delay: const Duration(milliseconds: 850),
                    child: _CompletionAction(
                      label: 'EXPLORE WORKOUT 2 LIBRARY',
                      icon: LucideIcons.bookOpen,
                      onTap: () => context.push('/hub/library/workout2'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    delay: const Duration(milliseconds: 900),
                    child: _CompletionAction(
                      label: 'TOOLS HUB',
                      icon: LucideIcons.layoutGrid,
                      onTap: () => context.go('/hub'),
                    ),
                  ),
                  const SizedBox(height: 48),
                  FadeIn(
                    delay: const Duration(milliseconds: 1400),
                    child: TextButton(
                      onPressed: () => context.go('/'),
                      child: Text(
                        'RETURN TO DASHBOARD',
                        style: AppTypography.columnHeader.copyWith(
                          fontSize: 9,
                          letterSpacing: 2.0,
                          color: AppColors.ink.withOpacity(0.35),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletionAction extends StatelessWidget {
  final String label;
  final String? subLabel;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _CompletionAction({
    required this.label,
    this.subLabel,
    required this.icon,
    this.isPrimary = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.accent : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isPrimary ? AppColors.accent : AppColors.line.withOpacity(0.3)),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                      color: AppColors.accent.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10))
                ]
              : [],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.columnHeader.copyWith(
                      fontSize: 11,
                      letterSpacing: 1.2,
                      color: isPrimary ? Colors.white : AppColors.ink,
                    ),
                  ),
                  if (subLabel != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subLabel!,
                      style: AppTypography.p.copyWith(
                        fontSize: 13,
                        color: isPrimary
                            ? Colors.white.withOpacity(0.7)
                            : AppColors.ink.withOpacity(0.5),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              icon,
              size: 18,
              color: isPrimary ? Colors.white : AppColors.ink.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}

