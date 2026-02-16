import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_svg/svg.dart';

// Card 3/4: Product Card
class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String price;
  final String calories;
  final String weight;
  final VoidCallback? onAdd;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.price,
    required this.calories,
    required this.weight,
    this.onAdd,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        clipBehavior: Clip.antiAlias,
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Container
                Container(
                  width: 120,
                  height: 80,
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
                // Content
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      _buildInfoItem(Icons.attach_money, price),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildInfoItem(Icons.local_fire_department, calories),
                          const SizedBox(width: 6),
                          _buildInfoItem(Icons.scale, weight),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Add Button
            Positioned(
              right: 7,
              top: 7,
              child: GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: ShapeDecoration(
                    color: primaryGreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/warung/troli.svg',
                      width: 15,
                      height: 15,
                      colorFilter: ColorFilter.mode(txtWhite, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 10, color: txtPrimary),
        const SizedBox(width: 3),
        Text(
          text,
          style: TextStyle(
            color: txtPrimary,
            fontSize: 10,
            fontFamily: 'Visby Round CF',
            fontWeight: medium,
            height: 1.40,
          ),
        ),
      ],
    );
  }
}
