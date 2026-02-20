import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

/// A reusable section header widget used in checkout/order pages.
/// Shows a label on the left and a tappable "Lihat Semua" link on the right.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel = 'Lihat Semua',
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: txtPrimary,
            fontSize: 12,
            fontFamily: visbyRoundCF,
            fontWeight: medium,
            height: 2,
          ),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: onActionTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionLabel!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryGreenColor,
                    fontSize: 12,
                    fontFamily: visbyRoundCF,
                    fontWeight: medium,
                    height: 2,
                  ),
                ),
                const SizedBox(width: 2),
                Icon(Icons.chevron_right, size: 14, color: primaryGreenColor),
              ],
            ),
          ),
      ],
    );
  }
}
