import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/shared/widgets/app_button.dart';
import 'package:lmm_app/features/auth/domain/models/onboarding_content.dart';
import 'package:lmm_app/features/auth/presentation/providers/onboarding_provider.dart';

class OnboardingFlow extends ConsumerStatefulWidget {
  const OnboardingFlow({super.key});

  @override
  ConsumerState<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends ConsumerState<OnboardingFlow> {
  final PageController _pageController = PageController();

  void _onStepContinue() {
    final currentStep = ref.read(onboardingStepProvider);
    if (currentStep < OnboardingStepModel.steps.length - 1) {
      ref.read(onboardingStepProvider.notifier).state++;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: OnboardingStepModel.steps.length,
        itemBuilder: (context, index) {
          final step = OnboardingStepModel.steps[index];
          return _OnboardingStepView(
            step: step,
            onContinue: _onStepContinue,
          );
        },
      ),
    );
  }
}

class _OnboardingStepView extends StatelessWidget {
  final OnboardingStepModel step;
  final VoidCallback onContinue;

  const _OnboardingStepView({required this.step, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final isWelcome = step.type == OnboardingStepType.welcome;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          if (isWelcome) ...[
            Image.asset(
              'assets/images/logo/logo-black.png',
              height: 100,
            ),
          ],
          if (!isWelcome) ...[
            Text(
              'STEP ${step.stepIndex} OF 7'.toUpperCase(),
              style: AppTypography.columnHeader.copyWith(
                color: AppColors.ink.withOpacity(0.2),
                letterSpacing: 3.0,
              ),
            ),
            const SizedBox(height: 12),
          ],
          Text(
            step.title,
            style: AppTypography.h1.copyWith(
              fontSize: isWelcome ? 48 : 36,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          if (step.subtitle != null) ...[
            const SizedBox(height: 16),
            Text(
              step.subtitle!,
              style: AppTypography.p.copyWith(
                fontSize: 18,
                color: AppColors.ink.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const Spacer(flex: 2),
          _buildContent(),
          const Spacer(flex: 3),
          if (step.footerText != null) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Text(
                step.type == OnboardingStepType.welcome || step.type == OnboardingStepType.negativePoints 
                    ? step.footerText! 
                    : step.footerText!.toUpperCase(),
                style: AppTypography.columnHeader.copyWith(
                  fontSize: 10,
                  letterSpacing: isWelcome ? 2.5 : 1.5,
                  color: isWelcome ? AppColors.ink.withOpacity(0.5) : AppColors.ink.withOpacity(0.3),
                  height: 1.8,
                  textBaseline: TextBaseline.alphabetic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          SizedBox(
            width: 240,
            child: AppButton(
              text: step.buttonLabel!,
              icon: LucideIcons.play,
              onPressed: onContinue,
              type: AppButtonType.primary,
            ),
          ),
          if (isWelcome) ...[
            const SizedBox(height: 24),
            Text(
              'ALREADY HAVE AN ACCOUNT? LOGIN',
              style: AppTypography.columnHeader.copyWith(
                fontSize: 10,
                color: AppColors.ink.withOpacity(0.2),
                letterSpacing: 2.0,
              ),
            ),
          ],
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (step.type) {
      case OnboardingStepType.welcome:
        return const SizedBox.shrink();
      case OnboardingStepType.simpleBody:
        return Text(
          step.body ?? '',
          style: AppTypography.p.copyWith(
            fontSize: 16,
            color: AppColors.ink.withOpacity(0.6),
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        );
      case OnboardingStepType.createAccount:
        return Column(
          children: [
            _AccountOption(
              icon: LucideIcons.mail,
              label: 'Continue with Email',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _AccountOption(
              icon: LucideIcons.apple,
              label: 'Continue with Apple',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _AccountOption(
              icon: LucideIcons.chrome,
              label: 'Continue with Google',
              onTap: () {},
            ),
          ],
        );
      case OnboardingStepType.bulletPoints:
      case OnboardingStepType.negativePoints:
        return Column(
          children: step.mainPoints!
              .map((p) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      p,
                      style: AppTypography.p.copyWith(
                        fontSize: 16,
                        color: AppColors.ink.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ))
              .toList(),
        );
      case OnboardingStepType.listItems:
        return Column(
          children: step.listItems!
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.ink.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(item.icon, size: 24, color: AppColors.ink),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: AppTypography.columnHeader.copyWith(
                                  fontSize: 12,
                                  letterSpacing: 1.5,
                                  color: AppColors.ink,
                                ),
                              ),
                              Text(
                                item.description,
                                style: AppTypography.p.copyWith(
                                  fontSize: 14,
                                  color: AppColors.ink.withOpacity(0.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        );
    }
  }
}

class _AccountOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AccountOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.ink.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.ink),
            const SizedBox(width: 16),
            Text(
              label,
              style: AppTypography.p.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
