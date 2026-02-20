import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/widgets/quantity_counter.dart';

class CartItemWidget extends StatelessWidget {
  final String productName;
  final double price;
  final String? imageUrl;
  final int quantity;
  final bool isSelected;
  final VoidCallback onToggleSelect;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemWidget({
    super.key,
    required this.productName,
    required this.price,
    this.imageUrl,
    required this.quantity,
    required this.isSelected,
    required this.onToggleSelect,
    required this.onIncrement,
    required this.onDecrement,
  });

  String _formatPrice(double value) {
    final str = value.toStringAsFixed(0);
    final buffer = StringBuffer();
    final offset = str.length % 3;
    for (int i = 0; i < str.length; i++) {
      if (i != 0 && (i - offset) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggleSelect,
          child: Container(
            width: 24,
            height: 24,
            decoration: ShapeDecoration(
              color: isSelected ? primaryGreenColor : lightBackgroundColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: isSelected ? primaryGreenColor : txtPrimary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: isSelected
                ? Icon(Icons.check, size: 16, color: txtWhite)
                : null,
          ),
        ),
        const SizedBox(width: 7),
        Container(
          width: 96,
          height: 95,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFCBCBCB)),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.shopping_bag_outlined,
                      color: txtSecondary,
                      size: 40,
                    );
                  },
                )
              : Icon(
                  Icons.shopping_bag_outlined,
                  color: txtSecondary,
                  size: 40,
                ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: TextStyle(
                  color: txtPrimary,
                  fontSize: 12,
                  fontFamily: 'Visby Round CF',
                  fontWeight: semiBold,
                  height: 2,
                ),
              ),
              Text(
                'Rp${_formatPrice(price)}',
                style: TextStyle(
                  color: txtPrimary,
                  fontSize: 12,
                  fontFamily: 'Visby Round CF',
                  fontWeight: medium,
                  height: 2,
                ),
              ),
              const SizedBox(height: 19),
              QuantityCounter(
                quantity: quantity,
                onIncrement: onIncrement,
                onDecrement: onDecrement,
                backgroundColor: primaryGreenColor,
                borderColor: primaryGreenColor,
                iconColor: txtWhite,
                textColor: txtWhite,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
