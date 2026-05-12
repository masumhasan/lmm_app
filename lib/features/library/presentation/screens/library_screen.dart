import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:go_router/go_router.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modules = [
      {
        'title': 'Workout 0: Attention Control',
        'subtitle': 'First controlled repetition. Establish training environment.',
        'muscle': 'Attention Control',
      },
      {
        'title': 'Workout 1: Story Separation',
        'subtitle': 'Today you train separating story from evidence.',
        'muscle': 'Story Separation',
      },
      {
        'title': 'Workout 2: Alarm Loop',
        'subtitle': 'Spot the second alarm (the echo) in real time.',
        'muscle': 'Alarm Loop Recognition',
      },
      {
        'title': 'Workout 3: Reset',
        'subtitle': 'Reclaiming Safety — teaching the system what “non-danger” feels like.',
        'muscle': 'Sensation Separation',
      },
      {
        'title': 'Workout 4: The Overthinking Mind',
        'subtitle': 'Internal noise & attention misplacement.',
        'muscle': 'Cognitive Distance',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 72, left: 24, right: 24, bottom: 24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Library',
                        style: AppTypography.h1.copyWith(fontSize: 34),
                      ),
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(LucideIcons.arrowLeft, 
                                 size: 16, 
                                 color: AppColors.ink.withOpacity(0.3)),
                            const SizedBox(width: 4),
                            Text(
                              'BACK',
                              style: AppTypography.columnHeader.copyWith(
                                fontSize: 10,
                                color: AppColors.ink.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Curated knowledge on the mechanism of mind.',
                    style: AppTypography.p.copyWith(
                      color: AppColors.ink.withOpacity(0.4),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final module = modules[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            module['muscle']!.toUpperCase(),
                            style: AppTypography.columnHeader.copyWith(
                              fontSize: 9,
                              color: AppColors.accent,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            module['title']!,
                            style: AppTypography.h2.copyWith(fontSize: 20),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            module['subtitle']!,
                            style: AppTypography.p.copyWith(
                              fontSize: 14,
                              color: AppColors.ink.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                'VIEW MODULE',
                                style: AppTypography.columnHeader.copyWith(
                                  fontSize: 10,
                                  color: AppColors.ink.withOpacity(0.3),
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                LucideIcons.chevronRight,
                                size: 16,
                                color: AppColors.ink.withOpacity(0.2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: modules.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 48)),
        ],
      ),
    );
  }
}
