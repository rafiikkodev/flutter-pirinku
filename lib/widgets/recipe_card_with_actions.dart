import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

// Card 2: Recipe Card with Actions
class RecipeCardWithActions extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String price;
  final String duration;
  final VoidCallback? onSave;
  final VoidCallback? onUpgrade;
  final VoidCallback? onTap;

  const RecipeCardWithActions({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.price,
    required this.duration,
    this.onSave,
    this.onUpgrade,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 149,
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
          children: [
            // Image Container
            Container(
              width: 149,
              height: 107,
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
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoItem(Icons.attach_money, price),
                      const SizedBox(width: 8),
                      _buildInfoItem(Icons.access_time, duration),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(child: _buildActionButton('Simpan', onSave)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildActionButton('Upgrade', onUpgrade)),
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

  Widget _buildActionButton(String label, VoidCallback? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 24,
        decoration: ShapeDecoration(
          color: primaryGreenColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: txtWhite,
              fontSize: 10,
              fontFamily: 'Visby Round CF',
              fontWeight: medium,
              height: 1.40,
            ),
          ),
        ),
      ),
    );
  }
}
