import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class WarungActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const WarungActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.20),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: txtWhite),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: txtWhite,
                fontSize: 12,
                fontFamily: 'Visby Round CF',
                fontWeight: semiBold,
                height: 1.17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
