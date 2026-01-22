import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class RemovableChip extends StatelessWidget {
  final String label;
  final VoidCallback? onDelete;
  final Color? backgroundColor;
  final Color? textColor;

  const RemovableChip({
    Key? key,
    required this.label,
    this.onDelete,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: ShapeDecoration(
        color: backgroundColor ?? chipColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor ?? txtPrimary,
              fontSize: 14,
              fontFamily: 'Visby Round CF',
              fontWeight: medium,
            ),
          ),
          if (onDelete != null) ...[
            const SizedBox(width: 6),
            GestureDetector(
              onTap: onDelete,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: bgRedColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, size: 12, color: txtWhite),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
