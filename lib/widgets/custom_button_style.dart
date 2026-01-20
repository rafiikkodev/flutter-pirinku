import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

enum ButtonSize {
  small, // Auto-sizing
  medium, // 165px
  large, // 343px atau full width
}

enum ButtonStyle {
  primary, // Solid green background
  secondary, // Outlined with green border
  active, // Same as primary (for consistency)
  inactive, // Gray background
}

class CustomButtonStyle extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonStyle style;
  final double? customWidth;
  final double? height;

  const CustomButtonStyle({
    Key? key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.large,
    this.style = ButtonStyle.primary,
    this.customWidth,
    this.height,
  }) : super(key: key);

  double? _getWidth() {
    if (customWidth != null) return customWidth;

    switch (size) {
      case ButtonSize.small:
        return null; // Auto-sizing
      case ButtonSize.medium:
        return 165;
      case ButtonSize.large:
        return 343;
    }
  }

  Color _getBackgroundColor() {
    switch (style) {
      case ButtonStyle.primary:
      case ButtonStyle.active:
        return primaryGreenColor;
      case ButtonStyle.secondary:
        return primaryGreenColor.withOpacity(0.15);
      case ButtonStyle.inactive:
        return txtSecondary;
    }
  }

  Color _getTextColor() {
    switch (style) {
      case ButtonStyle.primary:
      case ButtonStyle.active:
        return txtWhite;
      case ButtonStyle.secondary:
        return primaryGreenColor;
      case ButtonStyle.inactive:
        return txtPrimary;
    }
  }

  Border? _getBorder() {
    if (style == ButtonStyle.secondary) {
      return Border.all(color: primaryGreenColor, width: 2);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = _getWidth();
    final isEnabled = onPressed != null;

    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        width: buttonWidth,
        height: height ?? 48,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          border: _getBorder(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _getTextColor(),
              fontSize: 14,
              fontFamily: 'Visby Round CF',
              fontWeight: semiBold,
            ),
          ),
        ),
      ),
    );
  }
}
