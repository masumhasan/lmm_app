import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

enum AppButtonType { primary, secondary, passive }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final IconData? icon;
  final bool isFullWidth;

  const AppButton({
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.icon,
    this.isFullWidth = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (type == AppButtonType.passive) {
      return TextButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: AppTypography.columnHeader.copyWith(
            letterSpacing: 2.0,
            fontSize: 10,
            color: AppColors.inkWithOpacity(0.3),
          ),
        ),
      );
    }

    final isPrimary = type == AppButtonType.primary;
    final backgroundColor = isPrimary ? AppColors.accent : AppColors.surface;
    final foregroundColor = isPrimary ? AppColors.surface : AppColors.ink;
    final border = isPrimary ? null : BorderSide(color: AppColors.line);

    Widget buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: 8),
        ],
        Text(text),
      ],
    );

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: isPrimary ? 8 : 0,
          shadowColor: isPrimary ? AppColors.accent.withOpacity(0.2) : Colors.transparent,
          side: border,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: AppTypography.btnText.copyWith(
            color: foregroundColor,
          ),
        ),
        child: buttonChild,
      ),
    );
  }
}
