import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

// Card 5: Recipe Card with View Recipe Button
class RecipeCardViewRecipe extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final VoidCallback? onViewRecipe;
  final VoidCallback? onFavorite;
  final VoidCallback? onTap;
  final bool isFavorite;

  const RecipeCardViewRecipe({
    Key? key,
    this.imageUrl,
    required this.title,
    this.onViewRecipe,
    this.onFavorite,
    this.onTap,
    this.isFavorite = false,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onViewRecipe,
                          child: Container(
                            height: 24,
                            decoration: ShapeDecoration(
                              color: primaryGreenColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Lihat Resep',
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
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onFavorite,
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 24,
                          color: isFavorite ? bgRedColor : txtPrimary,
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
}
