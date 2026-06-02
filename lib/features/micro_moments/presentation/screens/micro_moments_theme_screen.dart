import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/features/micro_moments/data/micro_moments_data.dart';
import 'package:lmm_app/features/micro_moments/domain/models/micro_moment_models.dart';

class MicroMomentsThemeScreen extends StatelessWidget {
  final String themeId;

  const MicroMomentsThemeScreen({super.key, required this.themeId});

  @override
  Widget build(BuildContext context) {
    final theme = microMomentsData.firstWhere((t) => t.id == themeId);

    return Scaffold(
      backgroundColor: AppColors.ink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    theme.title,
                    style: AppTypography.h1.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    theme.subtitle,
                    style: AppTypography.p.copyWith(
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: theme.moments.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white.withOpacity(0.05),
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final moment = theme.moments[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    title: Text(
                      moment.title,
                      style: AppTypography.h4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    onTap: () => context.push(
                      '/hub/micro-moments/$themeId/${moment.id}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
