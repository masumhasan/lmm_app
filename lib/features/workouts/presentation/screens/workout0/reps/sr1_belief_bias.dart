import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import '../widgets/workout0_penny_screen.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

class SR1BeliefBiasPlayScreen extends StatefulWidget {
  final VoidCallback onNext;
  const SR1BeliefBiasPlayScreen({required this.onNext, super.key});

  @override
  State<SR1BeliefBiasPlayScreen> createState() => _SR1BeliefBiasPlayScreenState();
}

class _SR1BeliefBiasPlayScreenState extends State<SR1BeliefBiasPlayScreen> {
  int currentRound = 1;
  final int totalRounds = 6;
  int? selectedIndex;
  bool isAdvancing = false;

  final List<List<String>> rounds = [
    ['“I might make a mistake.”', '“I might not.”'],
    ['“They could be judging me.”', '“They might not even notice.”'],
    ['“This could go badly.”', '“This could go fine.”'],
    ['“Something feels off.”', '“Nothing is actually wrong.”'],
    ['“I should think this through again.”', '“I’ve thought about this enough.”'],
    ['“I might not handle this well.”', '“I’ve handled things before.”'],
  ];

  void _onSelection(int index) async {
    if (isAdvancing) return;
    setState(() {
      selectedIndex = index;
      isAdvancing = true;
    });

    // Hold feedback for 1.4s
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;

    if (currentRound < totalRounds) {
      setState(() {
        currentRound++;
        selectedIndex = null;
        isAdvancing = false;
      });
    } else {
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentOptions = rounds[currentRound - 1];

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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _BeliefCard(
                  text: currentOptions[0],
                  isSelected: selectedIndex == 0,
                  isOtherSelected: selectedIndex != null && selectedIndex != 0,
                  onTap: () => _onSelection(0),
                ),
                const SizedBox(height: 24),
                _BeliefCard(
                  text: currentOptions[1],
                  isSelected: selectedIndex == 1,
                  isOtherSelected: selectedIndex != null && selectedIndex != 1,
                  onTap: () => _onSelection(1),
                ),
                if (isAdvancing)
                  FadeIn(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 48),
                      child: Column(
                        children: [
                          Text(
                            'That belief wasn’t chosen logically.',
                            style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.5)),
                          ),
                          Text(
                            'It felt familiar.',
                            style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BeliefCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isOtherSelected;
  final VoidCallback onTap;

  const _BeliefCard({
    required this.text,
    required this.isSelected,
    required this.isOtherSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 300),
        scale: isSelected ? 1.05 : 1.0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isOtherSelected ? 0.4 : 1.0,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.accent : AppColors.line.withOpacity(0.2),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ] : [],
            ),
            child: Text(
              text,
              style: AppTypography.h1.copyWith(fontSize: 20, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class SR1InsightScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SR1InsightScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PacedLine(text: '“Belief feels true.”', delay: 0),
          const SizedBox(height: 24),
          _PacedLine(text: '“But belief is often repetition.”', delay: 1400),
          const SizedBox(height: 24),
          _PacedLine(text: '“Repetition becomes familiarity.”', delay: 2800),
          const SizedBox(height: 24),
          _PacedLine(text: '“Familiarity becomes ‘truth.’”', delay: 4200),
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
