import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

/// Workout1_SR_Complete
class Workout1SRCompleteScreen extends StatefulWidget {
  final VoidCallback onContinueToWorkout2;
  final VoidCallback onCoachPreview;
  final VoidCallback onHome;
  const Workout1SRCompleteScreen({
    required this.onContinueToWorkout2,
    required this.onCoachPreview,
    required this.onHome,
    super.key,
  });

  @override
  State<Workout1SRCompleteScreen> createState() => _Workout1SRCompleteScreenState();
}

class _Workout1SRCompleteScreenState extends State<Workout1SRCompleteScreen> {
  int _phase = 0;

  @override
  void initState() {
    super.initState();
    _revealPhases();
  }

  void _revealPhases() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _phase = 1);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _phase = 2);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _phase = 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.2),
                  radius: 1.2,
                  colors: [AppColors.accent.withOpacity(0.03), Colors.transparent],
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeInUp(
                    child: Column(
                      children: [
                        Text(
                          'WORKOUT 1',
                          style: AppTypography.columnHeader.copyWith(
                            fontSize: 10,
                            letterSpacing: 4.0,
                            color: AppColors.ink.withOpacity(0.25),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "You're Seeing the Pattern",
                          style: AppTypography.h1.copyWith(fontSize: 34, fontStyle: FontStyle.italic, height: 1.1),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Phase 1 — Immediate Reflection
                  AnimatedOpacity(
                    opacity: _phase >= 0 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Text(
                          'The system creates stories automatically.',
                          style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.6)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "You don't have to follow them automatically.",
                          style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.6)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Phase 2 — Consolidation
                  AnimatedOpacity(
                    opacity: _phase >= 1 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You practiced:',
                          style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.5)),
                        ),
                        const SizedBox(height: 8),
                        _BulletPoint(text: 'Staying steady under interference'),
                        _BulletPoint(text: 'Resisting false certainty'),
                        _BulletPoint(text: 'Choosing concrete over story'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Phase 3 — Identity Shift
                  AnimatedOpacity(
                    opacity: _phase >= 2 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Text(
                          'Stories will still appear.',
                          style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5), fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Now you'll notice them sooner.",
                          style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5), fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'And respond differently.',
                          style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5), fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Action buttons
                  if (_phase >= 3) ...[
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      child: _CompletionAction(
                        label: 'CONTINUE TRAINING',
                        subLabel: 'Workout 2',
                        icon: LucideIcons.arrowRight,
                        isPrimary: true,
                        onTap: widget.onContinueToWorkout2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      child: _CompletionAction(
                        label: 'TALK IT THROUGH',
                        icon: LucideIcons.messageSquare,
                        isBadge: true,
                        onTap: () => context.go('/ai-coach'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FadeInUp(
                      delay: const Duration(milliseconds: 700),
                      child: _CompletionAction(
                        label: 'TOOLS HUB',
                        icon: LucideIcons.layoutGrid,
                        onTap: () => context.go('/hub'),
                      ),
                    ),
                    const SizedBox(height: 48),
                    FadeIn(
                      delay: const Duration(milliseconds: 1200),
                      child: TextButton(
                        onPressed: widget.onHome,
                        child: Text(
                          'RETURN HOME',
                          style: AppTypography.columnHeader.copyWith(
                            fontSize: 9,
                            letterSpacing: 2.0,
                            color: AppColors.ink.withOpacity(0.35),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.4))),
          Expanded(
            child: Text(text, style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.4))),
          ),
        ],
      ),
    );
  }
}

class _CompletionAction extends StatelessWidget {
  final String label;
  final String? subLabel;
  final IconData icon;
  final bool isPrimary;
  final bool isBadge;
  final VoidCallback onTap;

  const _CompletionAction({
    required this.label,
    this.subLabel,
    required this.icon,
    this.isPrimary = false,
    this.isBadge = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.accent : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isPrimary ? AppColors.accent : AppColors.line.withOpacity(0.3)),
          boxShadow: isPrimary
              ? [BoxShadow(color: AppColors.accent.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 10))]
              : [],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: AppTypography.columnHeader.copyWith(
                          fontSize: 11,
                          letterSpacing: 1.2,
                          color: isPrimary ? Colors.white : AppColors.ink,
                        ),
                      ),
                      if (isBadge) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('PREVIEW', style: AppTypography.mono.copyWith(fontSize: 7, color: AppColors.accent)),
                        ),
                      ],
                    ],
                  ),
                  if (subLabel != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subLabel!,
                      style: AppTypography.p.copyWith(
                        fontSize: 12,
                        color: isPrimary ? Colors.white.withOpacity(0.6) : AppColors.ink.withOpacity(0.4),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(icon, size: 16, color: isPrimary ? Colors.white : AppColors.ink.withOpacity(0.2)),
          ],
        ),
      ),
    );
  }
}
