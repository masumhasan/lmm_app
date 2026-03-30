import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/shared/widgets/premium_card.dart';

class TheoryCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final VoidCallback? onTap;

  const TheoryCard({
    required this.child,
    this.padding,
    this.borderRadius = 20, // To match the premium module look
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      borderRadius: borderRadius,
      onTap: onTap,
      child: child,
    );
  }
}
