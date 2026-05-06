import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Workout2JournalScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback onBack;
  const Workout2JournalScreen({
    required this.onNext,
    required this.onSkip,
    required this.onBack,
    super.key,
  });

  @override
  State<Workout2JournalScreen> createState() => _Workout2JournalScreenState();
}

class _Workout2JournalScreenState extends State<Workout2JournalScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
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
                Text('Training Log — Workout 2', style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.25))),
              ],
            ),
            const SizedBox(height: 56),
            FadeIn(child: Text('What was one Alarm Loop you noticed today?', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center)),
            const SizedBox(height: 10),
            FadeIn(delay: const Duration(milliseconds: 500), child: Text('What was the first spark?', style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.42)), textAlign: TextAlign.center)),
            const SizedBox(height: 34),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Type your reflection...',
                  hintStyle: AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.2)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: AppColors.line.withOpacity(0.2))),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: AppColors.line.withOpacity(0.2))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.accent, width: 1.4)),
                ),
              ),
            ),
            const SizedBox(height: 34),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 16),
              ),
              onPressed: widget.onNext,
              child: Text('Save Training Log Entry', style: AppTypography.btnText.copyWith(color: Colors.white)),
            ),
            const SizedBox(height: 14),
            TextButton(
              onPressed: widget.onSkip,
              child: Text('Skip for Now', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
            ),
          ],
        ),
      ),
    );
  }
}

class Workout2JournalConfirmScreen extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onHome;
  const Workout2JournalConfirmScreen({required this.onContinue, required this.onHome, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeIn(child: Text('Training log updated.\nEntry stored.\nRepetition builds recognition.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center)),
              const SizedBox(height: 18),
              Text('Skill Reps are optional. Workout completion logs after Skill Reps completion.', style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.24)), textAlign: TextAlign.center),
              const SizedBox(height: 34),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                ),
                onPressed: onContinue,
                child: Text('Continue to Skill Reps', style: AppTypography.btnText.copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  side: BorderSide(color: AppColors.line.withOpacity(0.7)),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                ),
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

