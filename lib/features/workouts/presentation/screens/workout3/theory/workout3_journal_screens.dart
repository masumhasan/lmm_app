import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Workout3TrainingLogScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback onBack;
  const Workout3TrainingLogScreen({required this.onNext, required this.onSkip, required this.onBack, super.key});
  @override
  State<Workout3TrainingLogScreen> createState() => _Workout3TrainingLogScreenState();
}

class _Workout3TrainingLogScreenState extends State<Workout3TrainingLogScreen> {
  final c = TextEditingController();
  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: widget.onBack,
                  child: Row(
                    children: [
                      Icon(LucideIcons.arrowLeft, size: 14, color: AppColors.ink.withOpacity(0.35)),
                      const SizedBox(width: 8),
                      Text('BACK', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.35))),
                    ],
                  ),
                ),
                Text('Training Log — Workout 3', style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.2))),
              ],
            ),
            const SizedBox(height: 56),
            Text('What sensation did you allow today…\nwithout reacting to it?', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('No explanation needed.', style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.45), fontStyle: FontStyle.italic)),
            const SizedBox(height: 28),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: TextField(
                controller: c,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Type reflection',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.line.withOpacity(0.3))),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.line.withOpacity(0.3))),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
              onPressed: widget.onNext,
              child: Text('Save Reflection', style: AppTypography.btnText.copyWith(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: widget.onSkip,
              child: Text('Skip for Now', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.35))),
            ),
          ],
        ),
      ),
    );
  }
}

class Workout3TrainingLogConfirmScreen extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onHome;
  const Workout3TrainingLogConfirmScreen({required this.onContinue, required this.onHome, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('This moment is saved.\nEntry stored.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
              const SizedBox(height: 26),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                onPressed: onContinue,
                child: Text('Continue to Skill Reps', style: AppTypography.btnText.copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), side: BorderSide(color: AppColors.line), padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16)),
                onPressed: onHome,
                child: Text('Return Home', style: AppTypography.btnText.copyWith(color: AppColors.ink.withOpacity(0.55))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

