import 'package:flutter/material.dart';

enum ButtonVariant { primary, destructive, outline, secondary, ghost, link }

enum ButtonSize { normal, sm, lg, icon }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.normal,
    this.icon,
  });

  // Define colors/styles for each variant
  ButtonStyle _getVariantStyle(BuildContext context) {
    final theme = Theme.of(context);
    switch (variant) {
      case ButtonVariant.destructive:
        return TextButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        );
      case ButtonVariant.outline:
        return OutlinedButton.styleFrom(
          side: BorderSide(color: theme.colorScheme.outline),
          foregroundColor: theme.colorScheme.onSurface,
        );
      case ButtonVariant.secondary:
        return TextButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary,
          foregroundColor: theme.colorScheme.onSecondary,
        );
      case ButtonVariant.ghost:
        return TextButton.styleFrom(
          foregroundColor: theme.colorScheme.onSurface,
          backgroundColor: Colors.transparent,
        );
      case ButtonVariant.link:
        return TextButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
          textStyle: const TextStyle(decoration: TextDecoration.underline),
        );
      case ButtonVariant.primary:
        return TextButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
        );
    }
  }

  // Define padding/size for each size variant
  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
      case ButtonSize.icon:
        return const EdgeInsets.all(12);
      case ButtonSize.normal:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _getVariantStyle(context).copyWith(
      padding: WidgetStateProperty.all(_getPadding()),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    if (variant == ButtonVariant.outline) {
      return OutlinedButton.icon(
        style: style,
        onPressed: onPressed,
        icon: icon ?? const SizedBox.shrink(),
        label: Text(label),
      );
    }

    return TextButton.icon(
      style: style,
      onPressed: onPressed,
      icon: icon ?? const SizedBox.shrink(),
      label: Text(label),
    );
  }
}
