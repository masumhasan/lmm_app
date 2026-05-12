import 'package:flutter/material.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:animate_do/animate_do.dart';

class Workout4PennyScreen extends StatelessWidget {
  final List<String> lines;
  final String repLabel;
  final VoidCallback onNext;

  const Workout4PennyScreen({
    required this.lines,
    required this.repLabel,
    required this.onNext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  // Completion Star Lottie
                  FadeInDown(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: AppColors.ink.withOpacity(0.04),
                          shape: BoxShape.circle),
                      child: Center(
                        child: DotLottieLoader.fromAsset(
                          'assets/lotties/workout_complete.lottie',
                          frameBuilder: (context, dotlottie) {
                            if (dotlottie != null) {
                              return Lottie.memory(
                                  dotlottie.animations.values.single);
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  for (int i = 0; i < lines.length; i++)
                    FadeInUp(
                      delay: Duration(milliseconds: 600 * (i + 1)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 8),
                        child: Text(
                          lines[i],
                          style: AppTypography.h2.copyWith(fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    delay: Duration(milliseconds: 600 * (lines.length + 1)),
                    child: Text(
                      '+1 $repLabel Rep',
                      style: AppTypography.columnHeader
                          .copyWith(color: AppColors.ink.withOpacity(0.5)),
                    ),
                  ),
                  const SizedBox(height: 120), // Space for bottom button
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 64,
            left: 0,
            right: 0,
            child: Center(
              child: FadeIn(
                delay: const Duration(seconds: 3),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 56, vertical: 20),
                  ),
                  onPressed: onNext,
                  child: const Text('Next'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
