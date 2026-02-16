import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class QuantityCounter extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final Color? textColor;
  final double? size;

  const QuantityCounter({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
    this.textColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Colors.white;
    final bColor = borderColor ?? primaryGreenColor;
    final iColor = iconColor ?? primaryGreenColor;
    final tColor = textColor ?? txtPrimary;
    final buttonSize = size ?? 32.0;
    final fontSize = size != null ? size! * 0.7 : 18.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: bColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: Container(
              width: buttonSize,
              height: buttonSize,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Icon(Icons.remove, size: buttonSize * 0.8, color: iColor),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: bColor),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              '$quantity',
              style: TextStyle(
                color: tColor,
                fontSize: fontSize,
                fontFamily: 'Visby Round CF',
                fontWeight: bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: onIncrement,
            child: Container(
              width: buttonSize,
              height: buttonSize,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Icon(Icons.add, size: buttonSize * 0.8, color: iColor),
            ),
          ),
        ],
      ),
    );
  }
}
