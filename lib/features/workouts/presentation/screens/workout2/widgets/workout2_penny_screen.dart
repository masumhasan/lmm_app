import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';

class Workout2PennyScreen extends StatefulWidget {
  final List<String> lines;
  final String repLoggedText;
  final VoidCallback onNext;
  final int minimumDisplayMs;

  const Workout2PennyScreen({
    required this.lines,
    required this.repLoggedText,
    required this.onNext,
    this.minimumDisplayMs = 4000,
    super.key,
  });

  @override
  State<Workout2PennyScreen> createState() => _Workout2PennyScreenState();
}

class _Workout2PennyScreenState extends State<Workout2PennyScreen> {
  bool _canContinue = false;

  @override
  void initState() {
    super.initState();
    debugPrint('LOGGING REP: ${widget.repLoggedText}');
    Future.delayed(Duration(milliseconds: widget.minimumDisplayMs), () {
      if (mounted) setState(() => _canContinue = true);
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
              padding: const EdgeInsets.symmetric(horizontal: 44),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < widget.lines.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: FadeIn(
                        delay: Duration(milliseconds: i * 600),
                        child: Text(
                          widget.lines[i],
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
            bottom: 126,
            left: 0,
            right: 0,
            child: FadeIn(
              delay: const Duration(milliseconds: 900),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.checkCircle2, size: 9, color: const Color(0xFF10B981).withOpacity(0.6)),
                  const SizedBox(width: 6),
                  Text(
                    'Rep Logged: ${widget.repLoggedText} +1',
                    style: AppTypography.columnHeader.copyWith(
                      fontSize: 9,
                      color: const Color(0xFF10B981).withOpacity(0.6),
                      letterSpacing: 1.2,
                    ),
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: widget.onNext,
                child: Text('▶ Continue', style: AppTypography.btnText.copyWith(color: Colors.white)),
              ),
            ),
        ],
      ),
    );
  }
}

