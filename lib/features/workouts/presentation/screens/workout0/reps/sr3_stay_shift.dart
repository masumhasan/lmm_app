import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

class SR3StayOrShiftPlayScreen extends StatefulWidget {
  final VoidCallback onNext;
  const SR3StayOrShiftPlayScreen({required this.onNext, super.key});

  @override
  State<SR3StayOrShiftPlayScreen> createState() => _SR3StayOrShiftPlayScreenState();
}

class _SR3StayOrShiftPlayScreenState extends State<SR3StayOrShiftPlayScreen> {
  int currentRound = 1;
  final int totalRounds = 4;
  bool? isShift;
  bool isAdvancing = false;

  final List<String> rounds = [
    '“Thinking about what might happen later.”',
    '“Replaying something you said.”',
    '“Analyzing a small mistake.”',
    '“Preparing for something uncertain.”',
  ];

  void _onSelection(bool shift) async {
    if (isAdvancing) return;
    setState(() {
      isShift = shift;
      isAdvancing = true;
    });

    // Advance after 1.4s
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;

    if (currentRound < totalRounds) {
      setState(() {
        currentRound++;
        isShift = null;
        isAdvancing = false;
      });
    } else {
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              'Round $currentRound of $totalRounds',
              style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.2)),
            ),
            const Spacer(),
            FadeIn(
              key: ValueKey(currentRound),
              child: Text(
                rounds[currentRound - 1],
                style: AppTypography.h1.copyWith(fontSize: 26, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
            if (isAdvancing && isShift != null)
              FadeIn(
                child: Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Text(
                    isShift! ? 'Notice: shifting creates distance.' : 'Notice: staying keeps it running.',
                    style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.5)),
                  ),
                ),
              ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: _SelectionButton(
                    label: 'STAY HERE',
                    isSelected: isShift == false,
                    isOtherSelected: isShift == true,
                    onTap: () => _onSelection(false),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _SelectionButton(
                    label: 'SHIFT AWAY',
                    isSelected: isShift == true,
                    isOtherSelected: isShift == false,
                    onTap: () => _onSelection(true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _SelectionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isOtherSelected;
  final VoidCallback onTap;

  const _SelectionButton({
    required this.label,
    required this.isSelected,
    required this.isOtherSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isOtherSelected ? 0.3 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accent : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isSelected ? AppColors.accent : AppColors.line.withOpacity(0.2)),
            boxShadow: isSelected ? [
              BoxShadow(color: AppColors.accent.withOpacity(0.15), blurRadius: 15, offset: const Offset(0, 5))
            ] : [],
          ),
          child: Text(
            label,
            style: AppTypography.btnText.copyWith(color: isSelected ? Colors.white : AppColors.ink),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class SR3InsightScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SR3InsightScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PacedLine(text: '“You didn’t learn a technique.”', delay: 0),
          const SizedBox(height: 24),
          _PacedLine(text: '“You saw the pattern.”', delay: 1400),
          const SizedBox(height: 24),
          _PacedLine(text: '“Belief. Pull. Position.”', delay: 2800),
          const SizedBox(height: 24),
          _PacedLine(text: '“All automatic.”', delay: 4200),
          const SizedBox(height: 24),
          _PacedLine(text: '“All trainable.”', delay: 5600),
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
