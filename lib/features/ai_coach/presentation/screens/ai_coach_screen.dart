import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/shared/widgets/premium_card.dart';

class AICoachScreen extends StatelessWidget {
  const AICoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LearnMyMind',
                      style: AppTypography.h1.copyWith(
                        fontSize: 28,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Text(
                      'COGNITIVE LABORATORY',
                      style: AppTypography.columnHeader.copyWith(
                        fontSize: 8,
                        color: AppColors.ink.withOpacity(0.3),
                        letterSpacing: 2.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.ink.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.ink.withOpacity(0.05)),
                  ),
                  child: Text(
                    'BETA v1.2',
                    style: AppTypography.columnHeader.copyWith(
                      fontSize: 8,
                      color: AppColors.ink.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // AI Coach Info Card
            PremiumCard(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C314E),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: const Icon(LucideIcons.bot, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Coach',
                          style: AppTypography.h2.copyWith(
                            fontSize: 24,
                            fontStyle: FontStyle.italic,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'SYSTEM STANDBY',
                              style: AppTypography.columnHeader.copyWith(
                                fontSize: 8,
                                color: AppColors.ink.withOpacity(0.3),
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.ink.withOpacity(0.03),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.ink.withOpacity(0.05)),
                    ),
                    child: Text(
                      'AI',
                      style: AppTypography.columnHeader.copyWith(
                        fontSize: 8,
                        color: AppColors.ink.withOpacity(0.2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),

            // Chat/Message Box
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.ink.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.ink.withOpacity(0.05)),
                  ),
                  child: Icon(LucideIcons.bot, size: 16, color: AppColors.ink.withOpacity(0.2)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ChatBubble(
                    text: 'Greetings. I am the LearnMyMind AI Coach. In future iterations, I will provide real-time cognitive interventions based on your physiological and psychological data.',
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    Icon(LucideIcons.triangle, size: 10, color: AppColors.ink.withOpacity(0.3)),
                    const SizedBox(height: 4),
                    Container(
                      width: 6,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.ink.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 6,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.ink.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Transform.rotate(
                      angle: 3.14159,
                      child: Icon(LucideIcons.triangle, size: 10, color: AppColors.ink.withOpacity(0.3)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 64),

            // Expansion Pending Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFF2C314E),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                   // Decorative Circles
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Opacity(
                      opacity: 0.1,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(LucideIcons.lock, color: Colors.white.withOpacity(0.4), size: 20),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Expansion Pending',
                            style: AppTypography.h2.copyWith(color: Colors.white, fontSize: 22),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Full neural integration, including real-time stress-response guidance, is scheduled for the next system expansion.',
                        style: AppTypography.p.copyWith(
                          color: Colors.white.withOpacity(0.5),
                          height: 1.6,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Icon(LucideIcons.activity, size: 12, color: Colors.white.withOpacity(0.3)),
                          const SizedBox(width: 12),
                          Text(
                            'LAYER B PROTOCOL REQUIRED',
                            style: AppTypography.columnHeader.copyWith(
                              color: Colors.white.withOpacity(0.3),
                              letterSpacing: 2.0,
                              fontSize: 9,
                            ),
                          ),
                        ],
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

class _ChatBubble extends StatefulWidget {
  final String text;
  const _ChatBubble({required this.text});

  @override
  State<_ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<_ChatBubble> {
  String displayedText = '';
  int charIndex = 0;
  Timer? timer;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => isVisible = true);
        _startTyping();
      }
    });
  }

  void _startTyping() {
    timer = Timer.periodic(const Duration(milliseconds: 20), (t) {
      if (charIndex < widget.text.length) {
        if (mounted) {
          setState(() {
            displayedText += widget.text[charIndex];
            charIndex++;
          });
        }
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isVisible ? 1.0 : 0.0,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.95, end: isVisible ? 1.0 : 0.95),
        duration: const Duration(milliseconds: 400),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                border: Border.all(color: AppColors.line.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                displayedText,
                style: AppTypography.p.copyWith(
                  color: AppColors.ink.withOpacity(0.7),
                  height: 1.6,
                  fontSize: 15,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
