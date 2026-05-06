import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:animate_do/animate_do.dart';

class Workout1PennyScreen extends StatefulWidget {
  final List<String> lines;
  final String repLoggedText;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final int minimumDisplayMs;

  const Workout1PennyScreen({
    required this.lines,
    required this.repLoggedText,
    required this.onNext,
    required this.onBack,
    this.minimumDisplayMs = 3000,
    super.key,
  });

  @override
  State<Workout1PennyScreen> createState() => _Workout1PennyScreenState();
}

class _Workout1PennyScreenState extends State<Workout1PennyScreen> {
  bool _canContinue = false;

  @override
  void initState() {
    super.initState();
    _triggerRepLogging();
    Future.delayed(Duration(milliseconds: widget.minimumDisplayMs), () {
      if (mounted) setState(() => _canContinue = true);
    });
  }

  void _triggerRepLogging() {
    debugPrint('LOGGING REP: ${widget.repLoggedText}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < widget.lines.length; i++)
                    Padding(
                      padding: EdgeInsets.only(bottom: i < widget.lines.length - 1 ? 16 : 0),
                      child: FadeIn(
                        delay: Duration(milliseconds: 600 * i),
                        duration: const Duration(seconds: 1),
                        child: Text(
                          '"${widget.lines[i]}"',
                          style: AppTypography.h2.copyWith(fontSize: 26, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
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
              delay: Duration(milliseconds: 600 * widget.lines.length + 400),
              child: Row(
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
            ),
          ),
          if (_canContinue)
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
                    '  Continue',
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
