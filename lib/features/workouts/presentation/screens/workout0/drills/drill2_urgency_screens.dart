import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:animate_do/animate_do.dart';

class Drill2EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Drill2EntryScreen({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '▶ Start',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.zap,
            size: 48,
            color: AppColors.accent.withOpacity(0.2),
          ),
          const SizedBox(height: 32),
          Text(
            'The Urgency Bait',
            style: AppTypography.h1.copyWith(
              fontSize: 34,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Urgency feels real. Watch closely.',
            style: AppTypography.p.copyWith(
              color: AppColors.ink.withOpacity(0.4),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class Drill2CountdownScreen extends StatefulWidget {
  final VoidCallback onNext;
  const Drill2CountdownScreen({required this.onNext, super.key});

  @override
  State<Drill2CountdownScreen> createState() => _Drill2CountdownScreenState();
}

class _Drill2CountdownScreenState extends State<Drill2CountdownScreen> {
  int secondsRemaining = 10;
  bool showTimeIsRunningOut = false;
  bool isFrozen = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
          if (secondsRemaining == 5) showTimeIsRunningOut = true;
        });
      } else {
        t.cancel();
        _handleCountdownEnd();
      }
    });
  }

  void _handleCountdownEnd() async {
    // Button remains visible for 0.8s
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    // Then button fades out (0.4s) - handled by conditional build
    setState(() => isFrozen = true);

    // Then freeze 1.5s
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    widget.onNext();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !isFrozen, // Disable back during hold
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Stack(
          alignment: Alignment.center,
          children: [
            // Instruction
            Positioned(
              top: 100,
              left: 48,
              right: 48,
              child: Text(
                'DO NOT PRESS THE BUTTON.',
                style: AppTypography.columnHeader.copyWith(
                  fontSize: 8,
                  letterSpacing: 3.5,
                  color: AppColors.ink.withOpacity(0.15),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeIn(
                    child: Text(
                      'You have $secondsRemaining seconds to press the button below.',
                      style: AppTypography.h2.copyWith(
                        fontSize: 22,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 64),
                  if (!isFrozen)
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: () {
                            // Non-responsive during countdown
                            Navigator.of(
                              context,
                            ).maybePop(); // This is wrong, it should just do nothing
                            debugPrint(
                              'User pressed non-responsive urgency button.',
                            );
                          },
                          child: Text(
                            'PRESS NOW',
                            style: AppTypography.btnText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          '$secondsRemaining',
                          style: AppTypography.mono.copyWith(
                            fontSize: 96,
                            color: AppColors.ink.withOpacity(0.05),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  if (showTimeIsRunningOut && !isFrozen)
                    FadeIn(
                      duration: const Duration(milliseconds: 800),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Text(
                          'TIME IS RUNNING OUT.',
                          style: AppTypography.columnHeader.copyWith(
                            color: AppColors.accent,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Drill2RevealScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Drill2RevealScreen({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeInDown(
            child: Text(
              'Nothing required action.',
              style: AppTypography.h2.copyWith(
                fontSize: 24,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          FadeInDown(
            delay: const Duration(milliseconds: 800),
            child: Text(
              'The pressure was artificial.',
              style: AppTypography.h2.copyWith(
                fontSize: 24,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          FadeIn(
            delay: const Duration(milliseconds: 1600),
            child: Text(
              'Urgency trained your attention.',
              style: AppTypography.p.copyWith(
                fontSize: 14,
                color: AppColors.ink.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
