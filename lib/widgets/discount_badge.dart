import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class DiscountBadge extends StatelessWidget {
  final String discountText;
  final Color? backgroundColor;
  final Color? textColor;

  const DiscountBadge({
    super.key,
    required this.discountText,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: ShapeDecoration(
        color: backgroundColor ?? primaryGreenColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        discountText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor ?? txtWhite,
          fontSize: 14,
          fontFamily: 'Visby Round CF',
          fontWeight: semiBold,
        ),
      ),
    );
  }
}
