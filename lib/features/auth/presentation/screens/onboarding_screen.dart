import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/shared/widgets/app_button.dart';
import 'package:animate_do/animate_do.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0B14),
      body: Stack(
        children: [
          // Background circles (Visual replica of SVG)
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: CustomPaint(
                painter: _CirclesPainter(),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Top section with logo
                Expanded(
                  flex: 3,
                  child: Center(
                    child: FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo/logo-black.png',
                            height: 120,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Bottom curved container
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Login',
                          style: AppTypography.h2.copyWith(fontSize: 32),
                        ),
                        const SizedBox(height: 48),
                        
                        // Input Field Mock 1
                        _MockInputField(label: 'EMAIL', placeholder: 'name@example.com'),
                        const SizedBox(height: 24),
                        
                        // Input Field Mock 2
                        _MockInputField(label: 'PASSWORD', placeholder: '••••••••', isObscured: true),
                        const SizedBox(height: 40),
                        
                        AppButton(
                          text: 'Start Training',
                          icon: LucideIcons.arrowRight,
                          onPressed: () {
                            // Navigate home
                          },
                        ),
                        const SizedBox(height: 32),
                        
                        Text(
                          'NEW HERE? START ONBOARDING',
                          style: AppTypography.columnHeader.copyWith(
                            fontSize: 10,
                            letterSpacing: 2.0,
                            color: AppColors.neutral,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MockInputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool isObscured;

  const _MockInputField({
    required this.label,
    required this.placeholder,
    this.isObscured = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withOpacity(0.04),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.columnHeader.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            placeholder,
            style: AppTypography.p.copyWith(
              color: AppColors.ink.withOpacity(0.2),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _CirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
      
    final center = Offset(size.width / 2, size.height / 2);
    
    for (var i = 1; i <= 15; i++) {
      paint.color = Colors.white.withOpacity(0.05 + (i * 0.01));
      canvas.drawCircle(center, 40.0 + (i * 30), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
