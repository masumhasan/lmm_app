import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:animate_do/animate_do.dart';

class Drill1ReflexScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Drill1ReflexScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<Drill1ReflexScreen> createState() => _Drill1ReflexScreenState();
}

class _Drill1ReflexScreenState extends State<Drill1ReflexScreen> {
  final List<String> notifications = [];
  bool isCompleted = false;

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
    setState(() => notifications.add('THIS NEEDS ATTENTION.'));

    await Future.delayed(const Duration(milliseconds: 3000));
    if (!mounted) return;
    setState(() => isCompleted = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Background - subtle logo
          Center(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/images/logo/logo-black.png',
                width: 280,
              ),
            ),
          ),

          // Header
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Text(
              'DRILL 1: REFLEX',
              style: AppTypography.columnHeader.copyWith(letterSpacing: 4.0, color: AppColors.ink.withOpacity(0.3)),
              textAlign: TextAlign.center,
            ),
          ),

          // Notification Stack
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: notifications.map((text) {
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
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(LucideIcons.bell, size: 14, color: AppColors.accent),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              text,
                              style: AppTypography.mono.copyWith(fontSize: 9, color: AppColors.ink),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Progress / Instructions
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: FadeIn(
              child: Text(
                isCompleted ? 'A GUESS CAN FEEL REAL — WITHOUT BEING EVIDENCE.' : 'JUST NOTICE THE PULL.',
                style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.2)),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Action
          if (isCompleted)
            Positioned(
              bottom: 64,
              left: 48,
              right: 48,
              child: FadeInUp(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
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
    );
  }
}
