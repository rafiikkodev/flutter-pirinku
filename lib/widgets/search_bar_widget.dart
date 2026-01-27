import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

  const SearchBar({
    super.key,
    this.hintText = 'Cari...',
    this.controller,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: readOnly ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: ShapeDecoration(
          color: lightBackgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: primaryGreenColor),
            borderRadius: BorderRadius.circular(500),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: readOnly
                  ? Text(
                      hintText,
                      style: TextStyle(
                        color: const Color(0xFFAFAFAF),
                        fontSize: 14,
                        fontFamily: 'Visby Round CF',
                        fontWeight: medium,
                        height: 1.43,
                      ),
                    )
                  : TextField(
                      controller: controller,
                      onChanged: onChanged,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: const Color(0xFFAFAFAF),
                          fontSize: 14,
                          fontFamily: 'Visby Round CF',
                          fontWeight: medium,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                        color: txtPrimary,
                        fontSize: 14,
                        fontFamily: 'Visby Round CF',
                        fontWeight: medium,
                      ),
                    ),
            ),
            const SizedBox(width: 10),
            Icon(Icons.search, size: 24, color: primaryGreenColor),
          ],
        ),
      ),
    );
  }
}
