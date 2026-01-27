import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/widgets/quantity_counter.dart';
import 'package:flutter_pirinku/widgets/discount_badge.dart';
import 'package:flutter_pirinku/pages/cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final String productName;
  final String? imageUrl;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercent;
  final String storeName;

  const ProductDetailPage({
    super.key,
    required this.productName,
    this.imageUrl,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercent,
    required this.storeName,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 0;

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  void _addToCart() {
    if (quantity > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartPage(
            items: [
              {
                'name': widget.productName,
                'price': widget.discountedPrice,
                'quantity': quantity,
                'image': widget.imageUrl,
                'storeName': widget.storeName,
              },
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 122),
                _buildProductImage(),
                _buildProductInfo(),
                _buildAboutProduct(),
                const SizedBox(height: 120), // Space for bottom controls
              ],
            ),
          ),
          // Fixed header
          _buildHeader(),
          // Fixed bottom controls
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 55, left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: lightBackgroundColor.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_back, size: 20, color: txtPrimary),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Produk',
                  style: TextStyle(
                    color: txtPrimary,
                    fontSize: 22,
                    fontFamily: 'Visby Round CF',
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Share product
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: lightBackgroundColor.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.share_outlined, size: 20, color: txtPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 210.94,
      decoration: BoxDecoration(color: txtSecondary),
      child: widget.imageUrl != null
          ? Image.network(
              widget.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 60,
                    color: txtWhite,
                  ),
                );
              },
            )
          : Center(
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 60,
                color: txtWhite,
              ),
            ),
    );
  }

  Widget _buildProductInfo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: lightBackgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 13),
          Text(
            widget.productName,
            style: TextStyle(
              color: txtPrimary,
              fontSize: 22,
              fontFamily: 'Visby Round CF',
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              DiscountBadge(discountText: 'Diskon ${widget.discountPercent}%'),
              const SizedBox(width: 9),
              Text(
                'Rp${widget.originalPrice.toStringAsFixed(0)}',
                style: TextStyle(
                  color: const Color(0xFFCBCBCB),
                  fontSize: 14,
                  fontFamily: 'Visby Round CF',
                  fontWeight: medium,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Text(
            'Rp${widget.discountedPrice.toStringAsFixed(0)}',
            style: TextStyle(
              color: txtPrimary,
              fontSize: 22,
              fontFamily: 'Visby Round CF',
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 13),
          Text(
            'Sertifikat: Halal\nKondisi: Baru\nMin. Pemesanan: 1 Buah\nToko: ${widget.storeName}',
            style: TextStyle(
              color: txtPrimary,
              fontSize: 14,
              fontFamily: 'Visby Round CF',
              fontWeight: medium,
              height: 1.20,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildAboutProduct() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tentang Produk',
            style: TextStyle(
              color: txtPrimary,
              fontSize: 22,
              fontFamily: 'Visby Round CF',
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ABC Sarden Saus Extra Pedas 155 g adalah perpaduan ikan pilihan dan saus cabai extra pedas yang diciptakan khusus bagi anda yang jago pedas. Mengandung cabai rawit, setiap kaleng Sarden ABC ini dibuat hanya dari bahan-bahan segar untuk menciptakan saus yang benar-benar lezat dan sesuai dengan selera Indonesia. Sarden ABC pilihan No. 1 keluarga Indonesia. Sarden ABC kaya akan Omega 3 dan 6 yang baik untuk perkembangan otak si kecil.',
            style: TextStyle(
              color: txtPrimary,
              fontSize: 12,
              fontFamily: 'Visby Round CF',
              fontWeight: medium,
              height: 1.67,
            ),
          ),
          const SizedBox(height: 13),
          Text(
            'Keunggulan',
            style: TextStyle(
              color: txtPrimary,
              fontSize: 20,
              fontFamily: 'Visby Round CF',
              fontWeight: semiBold,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '- Diformulasikan khusus untuk para pecinta pedas;\n- Tanpa Bahan Pengawet & Siap Saji;\n- Kaya Nutrisi Omega 3 & Omega 6 yang baik untuk perkembangan otak si kecil;\n- Tersedia dalam 3 Varian Rasa Favorit',
            style: TextStyle(
              color: txtPrimary,
              fontSize: 12,
              fontFamily: 'Visby Round CF',
              fontWeight: medium,
              height: 1.67,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QuantityCounter(
            quantity: quantity,
            onIncrement: _incrementQuantity,
            onDecrement: _decrementQuantity,
            backgroundColor: primaryGreenColor,
            borderColor: primaryGreenColor,
            iconColor: txtWhite,
            textColor: txtWhite,
            size: 16,
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: _addToCart,
            child: Container(
              width: double.infinity,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: ShapeDecoration(
                color: primaryGreenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Masukan ke keranjang',
                    style: TextStyle(
                      color: txtWhite,
                      fontSize: 14,
                      fontFamily: 'Visby Round CF',
                      fontWeight: semiBold,
                    ),
                  ),
                  Icon(Icons.shopping_cart, size: 26, color: txtWhite),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
