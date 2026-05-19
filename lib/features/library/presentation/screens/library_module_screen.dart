import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:go_router/go_router.dart';
import 'package:lmm_app/features/library/domain/models/library_content.dart';
import 'package:animate_do/animate_do.dart';

class LibraryModuleScreen extends StatefulWidget {
  final LibraryModuleModel module;

  const LibraryModuleScreen({required this.module, super.key});

  @override
  State<LibraryModuleScreen> createState() => _LibraryModuleScreenState();
}

class _LibraryModuleScreenState extends State<LibraryModuleScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(LucideIcons.arrowLeft, color: AppColors.ink.withOpacity(0.3), size: 20),
                  ),
                  const Spacer(),
                  Text(
                    'CARD ${_currentIndex + 1} OF ${widget.module.cards.length}'.toUpperCase(),
                    style: AppTypography.columnHeader.copyWith(
                      fontSize: 10,
                      letterSpacing: 2.0,
                      color: AppColors.ink.withOpacity(0.2),
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 20), // Balance the back button
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemCount: widget.module.cards.length,
                itemBuilder: (context, index) {
                  final card = widget.module.cards[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInDown(
                              duration: const Duration(milliseconds: 600),
                              child: Text(
                                card.title,
                                style: AppTypography.h1.copyWith(
                                  fontSize: 28,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            FadeIn(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 200),
                              child: Text(
                                card.body,
                                style: AppTypography.p.copyWith(
                                  fontSize: 15,
                                  height: 1.8,
                                  color: AppColors.ink.withOpacity(0.7),
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            if (index < widget.module.cards.length - 1)
                              FadeInUp(
                                delay: const Duration(milliseconds: 400),
                                child: Center(
                                  child: TextButton.icon(
                                    onPressed: () => _pageController.nextPage(
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOutCubic,
                                    ),
                                    icon: const Icon(LucideIcons.arrowRight, size: 16),
                                    label: Text(
                                      'NEXT CARD',
                                      style: AppTypography.columnHeader.copyWith(
                                        fontSize: 10,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColors.accent,
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Navigation
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _NavButton(
                        label: 'BACK TO LIBRARY',
                        icon: LucideIcons.bookOpen,
                        onTap: () => context.pop(),
                      ),
                      _NavButton(
                        label: 'EXIT TO HOME',
                        icon: LucideIcons.home,
                        onTap: () => context.go('/'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 20, color: AppColors.ink.withOpacity(0.3)),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTypography.columnHeader.copyWith(
              fontSize: 8,
              letterSpacing: 1.0,
              color: AppColors.ink.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
