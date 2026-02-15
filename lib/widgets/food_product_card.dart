import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class FoodProductCard extends StatelessWidget {
  final String? imageUrl;
  final String? imageAsset;
  final String name;
  final String price;
  final VoidCallback? onTap;

  const FoodProductCard({
    Key? key,
    this.imageUrl,
    this.imageAsset,
    required this.name,
    required this.price,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 206,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: lightBackgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadows: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 8,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image
            Container(
              width: 186,
              height: 132,
              decoration: BoxDecoration(
                color: txtSecondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: imageAsset != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/$imageAsset',
                        fit: BoxFit.cover,
                      ),
                    )
                  : imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: txtSecondary,
                            child: Icon(
                              Icons.restaurant,
                              size: 40,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),
                    )
                  : Icon(Icons.restaurant, size: 40, color: Colors.grey[400]),
            ),
            const SizedBox(height: 12),
            // Content
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: txtPrimary,
                      fontSize: 16,
                      fontFamily: 'Visby Round CF',
                      fontWeight: medium,
                      height: 0.88,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    price,
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
          ],
        ),
      ),
    );
  }
}
