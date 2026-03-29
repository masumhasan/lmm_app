import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:animate_do/animate_do.dart';

class Workout0EntryScreen extends StatefulWidget {
  final VoidCallback onNext;
  const Workout0EntryScreen({required this.onNext, super.key});

  @override
  State<Workout0EntryScreen> createState() => _Workout0EntryScreenState();
}

class _Workout0EntryScreenState extends State<Workout0EntryScreen> {
  int breathCycle = 0;
  bool isLocked = true;

  @override
  void initState() {
    super.initState();
    _startBreathCycle();
  }

  void _startBreathCycle() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    setState(() => breathCycle = 1);
    
    // Total cycle is 10s as per web app
    await Future.delayed(const Duration(seconds: 4)); // Inhale peak
    if (!mounted) return;
    
    await Future.delayed(const Duration(seconds: 6)); // Exhale back
    if (!mounted) return;
    setState(() {
      breathCycle = 2;
      isLocked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Nav fallback placeholder or back button
          Positioned(
            top: 60,
            left: 24,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(LucideIcons.arrowLeft, size: 14, color: AppColors.ink.withOpacity(0.3)),
                  const SizedBox(width: 8),
                  Text('BACK', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
                ],
              ),
            ),
          ),
          
          // Header Instruction
          Positioned(
            top: MediaQuery.of(context).size.height * 0.22,
            left: 0,
            right: 0,
            child: FadeIn(
              duration: const Duration(seconds: 1),
              child: Text(
                'TAKE ONE SLOW BREATH.',
                style: AppTypography.columnHeader.copyWith(
                  color: AppColors.ink.withOpacity(0.35),
                  letterSpacing: 2.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Central Animation
          Center(
            child: SizedBox(
              width: 256,
              height: 256,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Glow
                  _PulseCircle(breathCycle: breathCycle),
                  
                  // Brain Core
                  _BrainCircle(breathCycle: breathCycle),
                ],
              ),
            ),
          ),

          // Bottom Texts
          Positioned(
            top: MediaQuery.of(context).size.height * 0.62,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              height: 120,
              alignment: Alignment.center,
              child: _BreathText(breathCycle: breathCycle),
            ),
          ),

          // Action Button
          if (!isLocked && breathCycle == 2)
            Positioned(
              bottom: 96,
              left: 48,
              right: 48,
              child: FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: Column(
                  children: [
                    Text(
                      'YOU ARE TRAINING ATTENTION.',
                      style: AppTypography.columnHeader.copyWith(color: AppColors.ink.withOpacity(0.3)),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      ),
                      onPressed: widget.onNext,
                      child: Text(
                        '▶ Begin Workout',
                        style: AppTypography.btnText.copyWith(color: Colors.white),
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

class _PulseCircle extends StatelessWidget {
  final int breathCycle;
  const _PulseCircle({required this.breathCycle});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 4),
      curve: Curves.easeInOut,
      width: breathCycle == 1 ? 256 : 140,
      height: breathCycle == 1 ? 256 : 140,
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(breathCycle == 1 ? 0.08 : 0.03),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _BrainCircle extends StatelessWidget {
  final int breathCycle;
  const _BrainCircle({required this.breathCycle});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 4),
      curve: Curves.easeInOut,
      width: breathCycle == 1 ? 160 : 120,
      height: breathCycle == 1 ? 160 : 120,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.accent.withOpacity(0.1)),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          LucideIcons.brain,
          color: AppColors.accent.withOpacity(0.3),
          size: 32,
        ),
      ),
    );
  }
}

class _BreathText extends StatelessWidget {
  final int breathCycle;
  const _BreathText({required this.breathCycle});

  @override
  Widget build(BuildContext context) {
    if (breathCycle == 0) return const SizedBox.shrink();

    if (breathCycle == 1) {
      return FadeIn(
        child: Text(
          'Inhale: I’m here.',
          style: AppTypography.h2.copyWith(fontSize: 24, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      );
    }

    return FadeIn(
      child: Column(
        children: [
          Text(
            'Exhale: Back to now.',
            style: AppTypography.h2.copyWith(fontSize: 24, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'This is not about fixing your mind. This is the first repetition in training it.',
            style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.4)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
