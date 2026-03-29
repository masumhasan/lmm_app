import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class PremiumCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final bool hasBorder;
  final VoidCallback? onTap;

  const PremiumCard({
    required this.child,
    this.padding,
    this.borderRadius,
    this.hasBorder = true,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(borderRadius ?? 24),
          border: hasBorder ? Border.all(color: AppColors.line) : null,
          boxShadow: [
            BoxShadow(
              color: AppColors.ink.withOpacity(0.03),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
