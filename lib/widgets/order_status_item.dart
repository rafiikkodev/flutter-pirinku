import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class OrderStatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool hasNotification;
  final VoidCallback? onTap;

  const OrderStatusItem({
    super.key,
    required this.icon,
    required this.label,
    this.hasNotification = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 71,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: Stack(
                children: [
                  Icon(icon, size: 28, color: txtPrimary),
                  if (hasNotification)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEE6055),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: txtPrimary,
                fontSize: 12,
                fontFamily: 'Visby Round CF',
                fontWeight: medium,
                height: 1.17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
