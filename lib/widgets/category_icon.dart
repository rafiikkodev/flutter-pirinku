import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class CategoryIcon extends StatelessWidget {
  final String? imageUrl;
  final String label;
  final VoidCallback? onTap;

  const CategoryIcon({
    super.key,
    this.imageUrl,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            child: imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.category,
                          size: 30,
                          color: txtSecondary,
                        );
                      },
                    ),
                  )
                : Icon(Icons.category, size: 30, color: txtSecondary),
          ),
          const SizedBox(height: 8),
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
    );
  }
}
