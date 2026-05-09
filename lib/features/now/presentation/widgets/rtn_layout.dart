import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';

class RTNLayout extends StatelessWidget {
  final Widget child;
  final VoidCallback onBack;
  final VoidCallback? onNext;
  final String? nextButtonText;
  final bool showNextButton;
  final bool showLottieBackground;

  const RTNLayout({
    required this.child,
    required this.onBack,
    this.onNext,
    this.nextButtonText = 'Continue',
    this.showNextButton = true,
    this.showLottieBackground = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Lottie Background
          if (showLottieBackground)
            Positioned.fill(
              child: OverflowBox(
                maxWidth: double.infinity,
                maxHeight: double.infinity,
                child: Center(
                  child: Transform.scale(
                    scale: 1.5,
                    child: DotLottieLoader.fromAsset(
                      'assets/lotties/return-to-now.lottie',
                      frameBuilder: (BuildContext context, DotLottie? dotlottie) {
                        if (dotlottie != null) {
                          return Lottie.memory(
                            dotlottie.animations.values.first,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          // Nav
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onBack,
                  child: Row(
                    children: [
                      Icon(LucideIcons.arrowLeft, size: 14, color: AppColors.ink.withOpacity(0.3)),
                      const SizedBox(width: 8),
                      Text('BACK', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => context.go('/'),
                  behavior: HitTestBehavior.opaque,
                  child: Icon(LucideIcons.home, size: 18, color: AppColors.ink.withOpacity(0.1)),
                ),
              ],
            ),
          ),

          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: child,
            ),
          ),

          // Button
          if (showNextButton && onNext != null)
            Positioned(
              bottom: 64,
              left: 48,
              right: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  elevation: 0,
                ),
                onPressed: onNext,
                child: Text(
                  nextButtonText!,
                  style: AppTypography.btnText.copyWith(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
