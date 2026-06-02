import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/features/micro_moments/data/micro_moments_data.dart';

class MicroMomentCompletionScreen extends StatelessWidget {
  final String themeId;
  final String momentId;

  const MicroMomentCompletionScreen({
    super.key,
    required this.themeId,
    required this.momentId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = microMomentsData.firstWhere((t) => t.id == themeId);
    final moment = theme.moments.firstWhere((m) => m.id == momentId);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                moment.completionLine,
                textAlign: TextAlign.center,
                style: AppTypography.h1.copyWith(
                  color: Colors.white,
                  fontSize: 32,
                  height: 1.3,
                ),
              ),
              const Spacer(),
              _CompletionButton(
                label: 'Another Moment',
                isPrimary: true,
                onTap: () => context.pushReplacement('/hub/micro-moments/$themeId'),
              ),
              const SizedBox(height: 12),
              _CompletionButton(
                label: 'Themes',
                isPrimary: false,
                onTap: () => context.pushReplacement('/hub/micro-moments'),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => context.go('/'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Home',
                    style: AppTypography.p.copyWith(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompletionButton extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _CompletionButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: isPrimary ? Colors.white : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(100),
          border: isPrimary ? null : Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTypography.p.copyWith(
            color: isPrimary ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
