import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import '../widgets/workout3_content_layout.dart';

class Workout3SkillRepsEntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout3SkillRepsEntryScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
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
          Text('You’ve trained the body.\nNow train the mislabel.', style: AppTypography.h2.copyWith(fontSize: 28), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text('The body isn’t the problem, the prediction is.', style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout3SRIntroScreen extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onStart;
  final VoidCallback onSkip;
  final VoidCallback onBack;
  const Workout3SRIntroScreen({required this.title, required this.body, required this.onStart, required this.onSkip, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout3ContentLayout(
      onNext: onStart,
      onBack: onBack,
      showHome: false,
      nextButtonText: 'Start',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTypography.h1.copyWith(fontSize: 33), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(body, style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          TextButton(onPressed: onSkip, child: Text('Skip', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.35)))),
        ],
      ),
    );
  }
}

class Workout3SR1PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout3SR1PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout3SR1PlayScreen> createState() => _Workout3SR1PlayScreenState();
}

class _Workout3SR1PlayScreenState extends State<Workout3SR1PlayScreen> {
  int phase = 0;
  int sec = 20;
  Timer? t;
  @override
  void initState() {
    super.initState();
    _start(20);
  }

  void _start(int duration) {
    t?.cancel();
    sec = duration;
    t = Timer.periodic(const Duration(seconds: 1), (tt) {
      if (!mounted) return;
      setState(() => sec--);
      if (sec <= 0) {
        tt.cancel();
        if (phase == 0) {
          setState(() => phase = 1);
          Future.delayed(const Duration(seconds: 12), () {
            if (!mounted) return;
            setState(() => phase = 2);
          });
        } else if (phase == 2) {
          widget.onComplete();
        }
      }
    });
  }

  @override
  void dispose() {
    t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (phase == 0) ...[
              Text('Go.', style: AppTypography.h1.copyWith(fontSize: 44)),
              Text('$sec', style: AppTypography.h2.copyWith(fontSize: 200)),
            ] else if (phase == 1) ...[
              Text('Now Stop.', style: AppTypography.h1.copyWith(fontSize: 36)),
              const SizedBox(height: 8),
              Text('Notice what your body is doing.\nDo not regulate it.', style: AppTypography.p.copyWith(fontSize: 15), textAlign: TextAlign.center),
              const SizedBox(height: 14),
              ElevatedButton(onPressed: () {
                setState(() => phase = 2);
                _start(15);
              }, child: const Text('One More Time')),
            ] else ...[
              Text('Stay.', style: AppTypography.h1.copyWith(fontSize: 36)),
              const SizedBox(height: 8),
              Text('Do nothing.', style: AppTypography.h2.copyWith(fontSize: 28)),
              const SizedBox(height: 10),
              Text('$sec', style: AppTypography.h2.copyWith(fontSize: 170)),
            ],
          ],
        ),
      ),
    );
  }
}

class Workout3SR2PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout3SR2PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout3SR2PlayScreen> createState() => _Workout3SR2PlayScreenState();
}

class _Workout3SR2PlayScreenState extends State<Workout3SR2PlayScreen> {
  int sec = 45;
  bool tapped = false;
  Timer? t;
  @override
  void initState() {
    super.initState();
    t = Timer.periodic(const Duration(seconds: 1), (tt) {
      if (!mounted) return;
      setState(() => sec--);
      if (sec <= 0) {
        tt.cancel();
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prompt = sec == 33
        ? 'Is your heart faster?'
        : sec == 20
            ? 'Are you breathing differently?'
            : '';
    return GestureDetector(
      onTap: () {
        if (!tapped) setState(() => tapped = true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$sec', style: AppTypography.h1.copyWith(fontSize: 270)),
              const SizedBox(height: 8),
              Text('Let your body exist without checking it.', style: AppTypography.p.copyWith(fontSize: 15)),
              if (prompt.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(prompt, style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.35))),
              ],
              if (tapped) ...[
                const SizedBox(height: 10),
                Text('That was the monitoring reflex.', style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.45))),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class Workout3SR3PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout3SR3PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout3SR3PlayScreen> createState() => _Workout3SR3PlayScreenState();
}

class _Workout3SR3PlayScreenState extends State<Workout3SR3PlayScreen> {
  int round = 0;
  final rounds = const [
    ('HEART', 'What did your mind assume?', ['Neutral', 'Dangerous']),
    ('DIZZ', 'What completed in your mind?', ['Nothing', 'A meaning']),
    ('TIGHT', 'What did your mind assume?', ['Neutral', 'Dangerous']),
    ('CALM', 'What did your mind assume?', ['Safe', 'Suspicious']),
  ];
  String? feedback;

  void answer(int i) {
    if (round == 0) {
      feedback = i == 0 ? 'The word appeared. The meaning didn’t.' : 'The word appeared. The meaning was added.';
    } else if (round == 1) {
      feedback = i == 1 ? 'Notice how fast that happened.' : 'Your mind likely finished the word.';
    } else if (round == 2) {
      feedback = i == 0 ? 'The word appeared. The meaning didn’t.' : 'The word appeared. The meaning was added.';
    } else {
      feedback = i == 0 ? 'Sometimes calm is allowed.' : 'The mind flags change.';
    }
    setState(() {});
    Future.delayed(const Duration(milliseconds: 1100), () {
      if (!mounted) return;
      if (round == rounds.length - 1) {
        widget.onComplete();
      } else {
        setState(() {
          round++;
          feedback = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = rounds[round];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(r.$1, style: AppTypography.h1.copyWith(fontSize: 52)),
              const SizedBox(height: 12),
              Text(r.$2, style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.6)), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              for (int i = 0; i < r.$3.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent.withOpacity(0.08), foregroundColor: AppColors.ink, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), minimumSize: const Size.fromHeight(46)),
                    onPressed: () => answer(i),
                    child: Text(r.$3[i], style: AppTypography.p.copyWith(fontSize: 14)),
                  ),
                ),
              if (feedback != null) ...[
                const SizedBox(height: 8),
                Text(feedback!, style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class Workout3SkillRepsCompleteScreen extends StatelessWidget {
  final VoidCallback onContinueWorkout4;
  final VoidCallback onHome;
  const Workout3SkillRepsCompleteScreen(
      {required this.onContinueWorkout4, required this.onHome, super.key});
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
                          'WORKOUT 3',
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
                          'Nothing dangerous happened.\nYour mind predicted it would.',
                          style: AppTypography.h2.copyWith(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            color: AppColors.ink.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'You saw the gap.\nThat gap is power.',
                          style: AppTypography.p.copyWith(
                            fontSize: 18,
                            color: AppColors.ink.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'This is how fear weakens.',
                          style: AppTypography.h2.copyWith(
                            fontSize: 22,
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
                      'Workout completion logs on button tap.',
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
                      subLabel: 'Workout 4',
                      icon: LucideIcons.arrowRight,
                      isPrimary: true,
                      onTap: onContinueWorkout4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeInUp(
                    delay: const Duration(milliseconds: 850),
                    child: _CompletionAction(
                      label: 'EXPLORE WORKOUT 3 LIBRARY',
                      icon: LucideIcons.bookOpen,
                      onTap: () => context.push('/hub/library/workout3'),
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
              color: isPrimary
                  ? AppColors.accent
                  : AppColors.line.withOpacity(0.3)),
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

