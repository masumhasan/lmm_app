import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';

class Workout2ContentLayout extends StatelessWidget {
  final Widget child;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final String nextButtonText;
  final bool isDark;
  final bool showNextButton;
  final bool showHome;
  final int buttonDelayMs;

  const Workout2ContentLayout({
    required this.child,
    required this.onNext,
    required this.onBack,
    this.nextButtonText = '  Continue',
    this.isDark = false,
    this.showNextButton = true,
    this.showHome = true,
    this.buttonDelayMs = 300,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : AppColors.ink;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E2135) : AppColors.surface,
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onBack,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      Icon(LucideIcons.arrowLeft, size: 14, color: textColor.withOpacity(0.35)),
                      const SizedBox(width: 8),
                      Text(
                        'BACK',
                        style: AppTypography.columnHeader.copyWith(
                          fontSize: 10,
                          color: textColor.withOpacity(0.35),
                        ),
                      ),
                    ],
                  ),
                ),
                if (showHome)
                  GestureDetector(
                    onTap: () => context.go('/'),
                    child: Icon(LucideIcons.home, size: 18, color: textColor.withOpacity(0.25)),
                  ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: FadeIn(duration: const Duration(milliseconds: 450), child: child),
            ),
          ),
          if (showNextButton)
            Positioned(
              bottom: 64,
              left: 48,
              right: 48,
              child: FadeIn(
                delay: Duration(milliseconds: buttonDelayMs),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? Colors.white : AppColors.accent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  ),
                  onPressed: onNext,
                  child: Text(
                    nextButtonText,
                    style: AppTypography.btnText.copyWith(
                      color: isDark ? AppColors.accent : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

