import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeMenuIcon extends StatelessWidget {
  final String? iconAsset;
  final String label;
  final VoidCallback? onTap;

  const HomeMenuIcon({
    super.key,
    this.iconAsset,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 77,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 11,
          children: [
            // Icon
            Container(
              width: 50,
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: iconAsset != null
                  ? (iconAsset!.endsWith('.svg')
                        ? SvgPicture.asset(
                            'assets/$iconAsset',
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            'assets/$iconAsset',
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ))
                  : Icon(Icons.category, size: 30, color: txtSecondary),
            ),
            // Label
            SizedBox(
              width: 77,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: txtPrimary,
                  fontSize: 12,
                  fontFamily: 'Visby Round CF',
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
