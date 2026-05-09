import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:animate_do/animate_do.dart';

class Drill1EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Drill1EntryScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '\u25B6 Start',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Attention Control | Reflex Test',
            style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'You are training impulse resistance.',
            style: AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.4)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class Drill1ReflexScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Drill1ReflexScreen({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  State<Drill1ReflexScreen> createState() => _Drill1ReflexScreenState();
}

class _Drill1ReflexScreenState extends State<Drill1ReflexScreen> {
  final List<String> notifications = [];
  bool allShown = false;
  bool holdActive = false;
  int holdCount = 0;
  bool holdFailed = false;
  bool isCompleted = false;
  int _holdGeneration = 0;

  @override
  void initState() {
    super.initState();
    _startDrill();
  }

  void _startDrill() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    setState(() => notifications.add('NEW MESSAGE RECEIVED.'));

    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => notifications.add('REMINDER: YOU FORGOT SOMETHING.'));

    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() {
      notifications.add('THIS NEEDS ATTENTION.');
      allShown = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    _startHold();
  }

  void _startHold() {
    _holdGeneration++;
    final gen = _holdGeneration;
    setState(() {
      holdActive = true;
      holdCount = 0;
      holdFailed = false;
    });
    _runHold(gen);
  }

  void _runHold(int gen) async {
    for (var i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted || gen != _holdGeneration) return;
      setState(() => holdCount = i);
    }

    if (!mounted || gen != _holdGeneration) return;
    setState(() {
      holdActive = false;
      isCompleted = true;
    });
  }

  void _onUserTapped() {
    if (!holdActive) return;
    _holdGeneration++;
    setState(() {
      holdFailed = true;
      holdCount = 0;
    });
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      _startHold();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !holdActive,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onUserTapped,
        child: Scaffold(
          backgroundColor: AppColors.surface,
          body: Stack(
            children: [
              Center(
                child: Opacity(
                  opacity: 0.05,
                  child: Image.asset(
                    'assets/images/logo/logo-black.png',
                    width: 280,
                  ),
                ),
              ),

              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Text(
                  'DRILL 1: REFLEX',
                  style: AppTypography.columnHeader.copyWith(
                    letterSpacing: 4.0,
                    color: AppColors.ink.withOpacity(0.3),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...notifications.map((text) {
                        return FadeInDown(
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  LucideIcons.bell,
                                  size: 14,
                                  color: AppColors.accent,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    text,
                                    style: AppTypography.mono.copyWith(
                                      fontSize: 9,
                                      color: AppColors.ink,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      if (holdActive) ...[
                        const SizedBox(height: 32),
                        Text(
                          holdFailed ? 'Try again. Hold for 5 seconds.' : 'Hold: 5 seconds',
                          style: AppTypography.columnHeader.copyWith(
                            fontSize: 10,
                            color: holdFailed
                                ? Colors.red.withOpacity(0.5)
                                : AppColors.ink.withOpacity(0.3),
                            letterSpacing: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        if (holdCount > 0)
                          Text(
                            '$holdCount',
                            style: AppTypography.h1.copyWith(
                              fontSize: 48,
                              color: AppColors.ink.withOpacity(0.08),
                            ),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ],
                  ),
                ),
              ),

              if (isCompleted)
                Positioned(
                  bottom: 64,
                  left: 48,
                  right: 48,
                  child: FadeInUp(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: widget.onNext,
                      child: Text(
                        'Continue',
                        style: AppTypography.btnText.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Drill1RevealScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Drill1RevealScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<Drill1RevealScreen> createState() => _Drill1RevealScreenState();
}

class _Drill1RevealScreenState extends State<Drill1RevealScreen> {
  bool showLine1 = false;
  bool showLine2 = false;
  bool showLine3 = false;
  bool showCTA = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => showLine1 = true);
    });
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) setState(() => showLine2 = true);
    });
    Future.delayed(const Duration(milliseconds: 4400), () {
      if (mounted) setState(() => showLine3 = true);
    });
    Future.delayed(const Duration(milliseconds: 6000), () {
      if (mounted) setState(() => showCTA = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: widget.onNext,
      onBack: widget.onBack,
      showNextButton: showCTA,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedOpacity(
            opacity: showLine1 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            child: Text(
              'Your attention moved automatically.',
              style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          AnimatedOpacity(
            opacity: showLine2 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            child: Text(
              'That wasn\u2019t a conscious choice.',
              style: AppTypography.p.copyWith(
                fontSize: 18,
                color: AppColors.ink.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          AnimatedOpacity(
            opacity: showLine3 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            child: Text(
              'That was automatic conditioning.',
              style: AppTypography.h2.copyWith(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
