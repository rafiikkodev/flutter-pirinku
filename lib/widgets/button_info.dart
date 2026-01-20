import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

enum ButtonInfoType { primary, secondary, success, warning, danger, neutral }

class ButtonInfo extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ButtonInfoType type;
  final double iconSize;
  final double fontSize;

  const ButtonInfo({
    Key? key,
    required this.text,
    this.icon,
    this.onPressed,
    this.type = ButtonInfoType.primary,
    this.iconSize = 14,
    this.fontSize = 12,
  }) : super(key: key);

  Color _getBackgroundColor() {
    switch (type) {
      case ButtonInfoType.primary:
        return primaryGreenColor;
      case ButtonInfoType.secondary:
        return secondaryGreenColor;
      case ButtonInfoType.success:
        return thirtyGreenColor;
      case ButtonInfoType.warning:
        return bgYellowColor;
      case ButtonInfoType.danger:
        return bgRedColor;
      case ButtonInfoType.neutral:
        return txtSecondary;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case ButtonInfoType.warning:
        return txtPrimary;
      default:
        return txtWhite;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: ShapeDecoration(
          color: _getBackgroundColor(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: _getTextColor(), size: iconSize),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: _getTextColor(),
                fontSize: fontSize,
                fontFamily: 'Visby Round CF',
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
