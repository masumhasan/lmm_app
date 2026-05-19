import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

class LibraryModuleEntryScreen extends StatelessWidget {
  final int workoutIndex;
  final String title;
  final String muscle;
  final String onStartPath;

  const LibraryModuleEntryScreen({
    required this.workoutIndex,
    required this.title,
    required this.muscle,
    required this.onStartPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Background subtle detail
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withOpacity(0.02),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.arrowLeft, 
                             size: 16, 
                             color: AppColors.ink.withOpacity(0.3)),
                        const SizedBox(width: 8),
                        Text(
                          'BACK',
                          style: AppTypography.columnHeader.copyWith(
                            fontSize: 10,
                            color: AppColors.ink.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: Text(
                          muscle.toUpperCase(),
                          style: AppTypography.columnHeader.copyWith(
                            fontSize: 10,
                            color: AppColors.accent,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 100),
                        child: Text(
                          title,
                          style: AppTypography.h1.copyWith(
                            fontSize: 34,
                            height: 1.1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeIn(
                        duration: const Duration(milliseconds: 800),
                        delay: const Duration(milliseconds: 400),
                        child: Container(
                          width: 40,
                          height: 2,
                          color: AppColors.ink.withOpacity(0.1),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 600),
                        child: Text(
                          'Educational depth for your recent training. Understanding the mechanism changes the repetition.',
                          style: AppTypography.p.copyWith(
                            fontSize: 15,
                            color: AppColors.ink.withOpacity(0.5),
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(flex: 2),
                
                // Action
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 800),
                    child: GestureDetector(
                      onTap: () => context.push(onStartPath),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: AppColors.ink,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'VIEW MODULE CARDS',
                                style: AppTypography.columnHeader.copyWith(
                                  color: Colors.white,
                                  fontSize: 11,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                LucideIcons.arrowRight,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
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
