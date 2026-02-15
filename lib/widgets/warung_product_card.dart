import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class WarungProductCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String price;
  final String calories;
  final String weight;
  final VoidCallback? onAdd;
  final VoidCallback? onTap;

  const WarungProductCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.price,
    required this.calories,
    required this.weight,
    this.onAdd,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 164,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: lightBackgroundColor,
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Container(
                  width: double.infinity,
                  height: 148,
                  decoration: BoxDecoration(
                    color: txtSecondary.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image, size: 50, color: txtSecondary),
                        )
                      : Icon(Icons.image, size: 50, color: txtSecondary),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        title,
                        style: TextStyle(
                          color: txtPrimary,
                          fontSize: 12,
                          fontFamily: 'Visby Round CF',
                          fontWeight: semiBold,
                          height: 1.17,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Price
                      Row(
                        children: [
                          Icon(Icons.attach_money, size: 14, color: txtPrimary),
                          const SizedBox(width: 3),
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
                      const SizedBox(height: 6),
                      // Calories and Weight
                      Row(
                        children: [
                          // Calories
                          Icon(
                            Icons.local_fire_department,
                            size: 10,
                            color: txtPrimary,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            calories,
                            style: TextStyle(
                              color: txtPrimary,
                              fontSize: 10,
                              fontFamily: 'Visby Round CF',
                              fontWeight: medium,
                              height: 1.40,
                            ),
                          ),
                          const SizedBox(width: 4),
                          // Weight
                          Icon(Icons.scale, size: 10, color: txtPrimary),
                          const SizedBox(width: 3),
                          Text(
                            weight,
                            style: TextStyle(
                              color: txtPrimary,
                              fontSize: 10,
                              fontFamily: 'Visby Round CF',
                              fontWeight: medium,
                              height: 1.40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Add Button
            Positioned(
              right: 8,
              top: 8,
              child: GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 30,
                  height: 30,
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: primaryGreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Icon(Icons.add, color: txtWhite, size: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
