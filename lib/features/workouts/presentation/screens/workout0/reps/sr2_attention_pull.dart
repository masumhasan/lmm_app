import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

class SR2AttentionPullPlayScreen extends StatefulWidget {
  final VoidCallback onNext;
  const SR2AttentionPullPlayScreen({required this.onNext, super.key});

  @override
  State<SR2AttentionPullPlayScreen> createState() => _SR2AttentionPullPlayScreenState();
}

class _SR2AttentionPullPlayScreenState extends State<SR2AttentionPullPlayScreen> {
  int currentRound = 1;
  final int totalRounds = 8;
  String? tappedItem;
  bool isAdvancing = false;

  final List<List<String>> roundItems = [
    ['What if…', 'Later', 'Message', 'Nothing', 'That feeling'],
    ['That feeling', 'Nothing', 'What if…', 'Later', 'Message'],
    ['Later', 'That feeling', 'Nothing', 'Message', 'What if…'],
    ['Nothing', 'Message', 'Later', 'What if…', 'That feeling'],
    ['Message', 'What if…', 'That feeling', 'Later', 'Nothing'],
    ['What if…', 'Nothing', 'Message', 'That feeling', 'Later'],
    ['That feeling', 'Later', 'Nothing', 'Message', 'What if…'],
    ['Later', 'Message', 'What if…', 'Nothing', 'That feeling'],
  ];

  final List<String> darkItems = [
    'What if…', 'Message', 'That feeling', 'Nothing', 'Later', 'What if…', 'That feeling', 'Message'
  ];

  void _onTap(String item) async {
    if (isAdvancing) return;
    setState(() {
      tappedItem = item;
      isAdvancing = true;
    });

    // Auto-advance after 1.4s total
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;

    if (currentRound < totalRounds) {
      setState(() {
        currentRound++;
        tappedItem = null;
        isAdvancing = false;
      });
    } else {
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = roundItems[currentRound - 1];
    final darkItem = darkItems[currentRound - 1];

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Header
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Text(
              'Round $currentRound of $totalRounds',
              style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.2)),
              textAlign: TextAlign.center,
            ),
          ),

          // Layout Items
          Center(
            child: SizedBox(
              height: 400,
              width: 300,
              child: Stack(
                children: [
                   _PositionedItem(text: items[0], isDark: items[0] == darkItem, tapped: tappedItem == items[0], anyTapped: tappedItem != null, pos: 0, onTap: () => _onTap(items[0])),
                   _PositionedItem(text: items[1], isDark: items[1] == darkItem, tapped: tappedItem == items[1], anyTapped: tappedItem != null, pos: 1, onTap: () => _onTap(items[1])),
                   _PositionedItem(text: items[2], isDark: items[2] == darkItem, tapped: tappedItem == items[2], anyTapped: tappedItem != null, pos: 2, onTap: () => _onTap(items[2])),
                   _PositionedItem(text: items[3], isDark: items[3] == darkItem, tapped: tappedItem == items[3], anyTapped: tappedItem != null, pos: 3, onTap: () => _onTap(items[3])),
                   _PositionedItem(text: items[4], isDark: items[4] == darkItem, tapped: tappedItem == items[4], anyTapped: tappedItem != null, pos: 4, onTap: () => _onTap(items[4])),
                ],
              ),
            ),
          ),

          // Feedback
          if (isAdvancing)
            Positioned(
              bottom: 120,
              left: 48,
              right: 48,
              child: FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: Column(
                  children: [
                    Text(
                      'That was the pull.',
                      style: AppTypography.h2.copyWith(fontSize: 22, height: 1.4),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Attention moved automatically.',
                      style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.5)),
                      textAlign: TextAlign.center,
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

class _PositionedItem extends StatelessWidget {
  final String text;
  final bool isDark;
  final bool tapped;
  final bool anyTapped;
  final int pos;
  final VoidCallback onTap;

  const _PositionedItem({
    required this.text,
    required this.isDark,
    required this.tapped,
    required this.anyTapped,
    required this.pos,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final positions = [
      [20.0, 40.0],   // Top Left
      [150.0, 180.0], // Center Right
      [280.0, 20.0],  // Lower Left
      [50.0, 220.0],  // Top Right
      [320.0, 200.0], // Lower Right
    ];

    final p = positions[pos];

    return Positioned(
      top: p[0],
      left: p[1],
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 150),
          scale: tapped ? 1.03 : 1.0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: anyTapped && !tapped ? 0.35 : 1.0,
            child: Text(
              text,
              style: AppTypography.h2.copyWith(
                fontSize: 24,
                color: isDark ? AppColors.ink : AppColors.ink.withOpacity(0.4),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SR2InsightScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SR2InsightScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PacedLine(text: '“That was the pull.”', delay: 0),
          const SizedBox(height: 24),
          _PacedLine(text: '“Attention moved automatically.”', delay: 1400),
          const SizedBox(height: 24),
          _PacedLine(text: '“Now it’s visible.”', delay: 2800),
        ],
      ),
    );
  }
}

class _PacedLine extends StatelessWidget {
  final String text;
  final int delay;
  const _PacedLine({required this.text, required this.delay});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      duration: const Duration(milliseconds: 800),
      child: Text(
        text,
        style: AppTypography.h2.copyWith(fontSize: 22, height: 1.4),
        textAlign: TextAlign.center,
      ),
    );
  }
}
