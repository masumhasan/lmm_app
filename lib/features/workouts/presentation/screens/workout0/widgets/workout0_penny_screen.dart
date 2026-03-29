import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:animate_do/animate_do.dart';

class Workout0PennyScreen extends StatefulWidget {
  final String text1;
  final String text2;
  final String repLoggedText;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Workout0PennyScreen({
    required this.text1,
    required this.text2,
    required this.repLoggedText,
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  State<Workout0PennyScreen> createState() => _Workout0PennyScreenState();
}

class _Workout0PennyScreenState extends State<Workout0PennyScreen> {
  @override
  void initState() {
    super.initState();
    _triggerRepLogging();
  }

  void _triggerRepLogging() {
    // Developer note: Rep increments trigger ONLY when this Penny screen loads.
    debugPrint('LOGGING REP: ${widget.repLoggedText}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Header - Micro indicator
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: FadeIn(
              child: Text(
                'SYSTEM_RESPONSE_CONFIRMED',
                style: AppTypography.columnHeader.copyWith(
                  fontSize: 7,
                  color: AppColors.ink.withOpacity(0.15),
                  letterSpacing: 3.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Core Text
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeIn(
                    duration: const Duration(seconds: 1),
                    child: Text(
                      '"${widget.text1}"',
                      style: AppTypography.h2.copyWith(fontSize: 26, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeIn(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(seconds: 1),
                    child: Text(
                      '"${widget.text2}"',
                      style: AppTypography.h2.copyWith(fontSize: 26, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Rep Logged - Bottom micro line
          Positioned(
            bottom: 128,
            left: 0,
            right: 0,
            child: FadeIn(
              delay: const Duration(milliseconds: 1200),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.checkCircle2, size: 8, color: const Color(0xFF10B981).withOpacity(0.5)),
                      const SizedBox(width: 6),
                      Text(
                        'Rep Logged: ${widget.repLoggedText} +1'.toUpperCase(),
                        style: AppTypography.columnHeader.copyWith(
                          fontSize: 8,
                          color: const Color(0xFF10B981).withOpacity(0.5),
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // CTA
          Positioned(
            bottom: 64,
            left: 48,
            right: 48,
            child: FadeInUp(
              delay: const Duration(milliseconds: 1600),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                onPressed: widget.onNext,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '▶ Continue',
                      style: AppTypography.btnText.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
