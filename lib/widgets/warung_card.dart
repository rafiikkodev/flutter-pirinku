import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

// Card 4: Restaurant/Warung Card (from image)
class WarungCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double rating;
  final int reviewCount;
  final bool isOpen;
  final String closingTime;
  final VoidCallback? onTap;

  const WarungCard({
    Key? key,
    this.imageUrl,
    required this.name,
    required this.rating,
    required this.reviewCount,
    this.isOpen = true,
    required this.closingTime,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: lightBackgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadows: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 24,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Container - Flexible to fill available space
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: txtSecondary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(),
                      )
                    : null,
              ),
            ),
            // Content - Fixed size
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: txtPrimary,
                      fontSize: 14,
                      fontFamily: 'Visby Round CF',
                      fontWeight: semiBold,
                      height: 1.43,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        rating.toString(),
                        style: TextStyle(
                          color: txtPrimary,
                          fontSize: 12,
                          fontFamily: 'Visby Round CF',
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(width: 4),
                      _buildStars(rating),
                      const SizedBox(width: 4),
                      Text(
                        '($reviewCount)',
                        style: TextStyle(
                          color: txtSecondary,
                          fontSize: 12,
                          fontFamily: 'Visby Round CF',
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        isOpen ? 'Buka' : 'Tutup',
                        style: TextStyle(
                          color: isOpen ? thirtyGreenColor : bgRedColor,
                          fontSize: 12,
                          fontFamily: 'Visby Round CF',
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '.',
                        style: TextStyle(
                          color: txtPrimary,
                          fontSize: 12,
                          fontFamily: 'Visby Round CF',
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Tutup $closingTime',
                        style: TextStyle(
                          color: txtPrimary,
                          fontSize: 12,
                          fontFamily: 'Visby Round CF',
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, size: 16, color: bgYellowColor);
        } else if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half, size: 16, color: bgYellowColor);
        } else {
          return Icon(Icons.star_border, size: 16, color: txtSecondary);
        }
      }),
    );
  }
}
