import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

/// A reusable red info/alert banner widget for checkout flow.
/// Displays an icon and a message with a red background.
class CheckoutInfoBanner extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;

  const CheckoutInfoBanner({
    super.key,
    required this.message,
    this.icon = Icons.info_outlined,
    this.backgroundColor = const Color(0xFFEE6055),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 24,
            offset: Offset(0, -4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: txtWhite, size: 18),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: txtWhite,
                fontSize: 14,
                fontFamily: visbyRoundCF,
                fontWeight: semiBold,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
