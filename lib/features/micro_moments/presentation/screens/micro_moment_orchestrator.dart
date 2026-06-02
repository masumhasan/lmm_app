import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/features/micro_moments/data/micro_moments_data.dart';
import 'package:lmm_app/features/micro_moments/domain/models/micro_moment_models.dart';

class MicroMomentOrchestrator extends StatefulWidget {
  final String themeId;
  final String momentId;

  const MicroMomentOrchestrator({
    super.key,
    required this.themeId,
    required this.momentId,
  });

  @override
  State<MicroMomentOrchestrator> createState() => _MicroMomentOrchestratorState();
}

class _MicroMomentOrchestratorState extends State<MicroMomentOrchestrator> with TickerProviderStateMixin {
  late MicroMomentData moment;
  int currentScreenIndex = 0;
  int visibleLinesCount = 0;
  bool isTransitioning = false;

  @override
  void initState() {
    super.initState();
    final theme = microMomentsData.firstWhere((t) => t.id == widget.themeId);
    moment = theme.moments.firstWhere((m) => m.id == widget.momentId);
    _startScreen();
  }

  void _startScreen() async {
    setState(() {
      visibleLinesCount = 0;
      isTransitioning = true;
    });
    
    for (int i = 0; i < moment.screens[currentScreenIndex].lines.length; i++) {
      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;
      setState(() {
        visibleLinesCount = i + 1;
      });
    }
    
    setState(() {
      isTransitioning = false;
    });
  }

  void _nextScreen() {
    if (isTransitioning) return;

    if (currentScreenIndex < moment.screens.length - 1) {
      setState(() {
        currentScreenIndex++;
      });
      _startScreen();
    } else {
      context.pushReplacement(
        '/hub/micro-moments/${widget.themeId}/${widget.momentId}/completion',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenData = moment.screens[currentScreenIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: currentScreenIndex == 1 ? 1.0 : 1.5, // Subtle variation
                  colors: [
                    const Color(0xFF1A1A1A),
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
          
          // Content
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _nextScreen,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(screenData.lines.length, (index) {
                    final text = screenData.lines[index];
                    final isActuallySmall = (currentScreenIndex == 0 && index > 0) || 
                                           (currentScreenIndex == 2 && index > 1) ||
                                           (currentScreenIndex == 3 && index > 0);

                    return AnimatedOpacity(
                      opacity: index < visibleLinesCount ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeOut,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: isActuallySmall
                              ? AppTypography.p.copyWith(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18,
                                  height: 1.5,
                                )
                              : AppTypography.h1.copyWith(
                                  color: Colors.white,
                                  fontSize: 32,
                                  height: 1.3,
                                ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),

          // Header
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white54),
                    onPressed: () => context.pop(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white54),
                    onPressed: () => context.go('/'),
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
