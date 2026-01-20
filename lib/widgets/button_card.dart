import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

enum ButtonCardType { primary, secondary, success, warning, danger }

class ButtonCard extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonCardType type;
  final double? width;
  final double height;
  final double fontSize;

  const ButtonCard({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = ButtonCardType.primary,
    this.width,
    this.height = 20,
    this.fontSize = 8,
  }) : super(key: key);

  Color _getBackgroundColor() {
    switch (type) {
      case ButtonCardType.primary:
        return primaryGreenColor;
      case ButtonCardType.secondary:
        return secondaryGreenColor;
      case ButtonCardType.success:
        return thirtyGreenColor;
      case ButtonCardType.warning:
        return bgYellowColor;
      case ButtonCardType.danger:
        return bgRedColor;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case ButtonCardType.warning:
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
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: ShapeDecoration(
          color: _getBackgroundColor(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _getTextColor(),
              fontSize: fontSize,
              fontFamily: 'Visby Round CF',
              fontWeight: regular,
            ),
          ),
        ),
      ),
    );
  }
}
