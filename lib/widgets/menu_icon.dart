import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class MenuIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backgroundColor;

  const MenuIcon({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 77,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: backgroundColor ?? bgRedColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor ?? txtWhite, size: 24),
            ),
            const SizedBox(height: 11),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: txtPrimary,
                fontSize: 12,
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
