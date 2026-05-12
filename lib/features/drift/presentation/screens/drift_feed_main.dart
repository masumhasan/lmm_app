import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/features/drift/domain/models/drift_card_model.dart';
import 'package:lmm_app/features/drift/presentation/widgets/drift_card_renderer.dart';

class DriftFeedMain extends StatefulWidget {
  const DriftFeedMain({super.key});

  @override
  State<DriftFeedMain> createState() => _DriftFeedMainState();
}

class _DriftFeedMainState extends State<DriftFeedMain> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<DriftCardModel> _cards = DriftCardModel.firstEightDriftCards;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: Stack(
        children: [
          // Feed
          PageView.builder(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index % _cards.length;
              });
            },
            itemBuilder: (context, index) {
              final actualIndex = index % _cards.length;
              return DriftCardRenderer(
                card: _cards[actualIndex],
                isActive: _currentIndex == actualIndex,
              );
            },
          ),
          
          // Top UI Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Drift',
                    style: AppTypography.h3.copyWith(
                      color: const Color(0xFF2E3A59).withOpacity(0.5),
                      letterSpacing: 1.2,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.arrowLeft, color: Color(0xFF2E3A59), size: 24),
                    onPressed: () => context.go('/home'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
