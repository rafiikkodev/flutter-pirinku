import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

enum AlertType { error, warning, success, info }

class CustomAlert extends StatelessWidget {
  final String message;
  final AlertType type;
  final bool isDismissible;
  final VoidCallback? onDismiss;

  const CustomAlert({
    Key? key,
    required this.message,
    this.type = AlertType.error,
    this.isDismissible = false,
    this.onDismiss,
  }) : super(key: key);

  Color _getBackgroundColor() {
    switch (type) {
      case AlertType.error:
        return bgRedColor;
      case AlertType.warning:
        return bgYellowColor;
      case AlertType.success:
        return thirtyGreenColor;
      case AlertType.info:
        return primaryGreenColor;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case AlertType.error:
        return Icons.error_outline;
      case AlertType.warning:
        return Icons.warning_amber_outlined;
      case AlertType.success:
        return Icons.check_circle_outline;
      case AlertType.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      constraints: const BoxConstraints(minHeight: 68),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: ShapeDecoration(
        color: _getBackgroundColor(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 24,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Icon(_getIcon(), color: txtWhite, size: 32),
          const SizedBox(width: 12),

          // Message
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: txtWhite,
                fontSize: 14,
                fontFamily: 'Visby Round CF',
                fontWeight: medium,
              ),
            ),
          ),

          // Dismiss button (optional)
          if (isDismissible)
            GestureDetector(
              onTap: () {
                onDismiss?.call();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(Icons.close, color: txtWhite, size: 20),
              ),
            ),
        ],
      ),
    );
  }
}
