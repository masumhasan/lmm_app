import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';

class Workout3PennyScreen extends StatefulWidget {
  final List<String> lines;
  final String repLabel;
  final int minDisplayMs;
  final VoidCallback onNext;

  const Workout3PennyScreen({
    required this.lines,
    required this.repLabel,
    required this.onNext,
    this.minDisplayMs = 4000,
    super.key,
  });

  @override
  State<Workout3PennyScreen> createState() => _Workout3PennyScreenState();
}

class _Workout3PennyScreenState extends State<Workout3PennyScreen> {
  bool _showCta = false;
  @override
  void initState() {
    super.initState();
    debugPrint('LOGGING REP: ${widget.repLabel}');
    Future.delayed(Duration(milliseconds: widget.minDisplayMs), () {
      if (mounted) setState(() => _showCta = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < widget.lines.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AnimatedOpacity(
                        opacity: 1,
                        duration: Duration(milliseconds: 500 + i * 200),
                        child: Text(widget.lines[i], style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 128,
            left: 0,
            right: 0,
            child: FadeIn(
              delay: const Duration(milliseconds: 900),
              child: FadeOut(
                delay: const Duration(milliseconds: 2900),
                duration: const Duration(seconds: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.checkCircle2, size: 9, color: const Color(0xFF10B981).withOpacity(0.6)),
                    const SizedBox(width: 6),
                    Text('Rep Logged: ${widget.repLabel} +1', style: AppTypography.columnHeader.copyWith(fontSize: 8, color: const Color(0xFF10B981).withOpacity(0.6))),
                  ],
                ),
              ),
            ),
          ),
          if (_showCta)
            Positioned(
              bottom: 64,
              left: 48,
              right: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: widget.onNext,
                child: Text('  Continue', style: AppTypography.btnText.copyWith(color: Colors.white)),
              ),
            ),
        ],
      ),
    );
  }
}

