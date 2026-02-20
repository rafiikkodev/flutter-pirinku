import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/pages/order_success_page.dart';
import 'package:flutter_pirinku/widgets/checkout_info_banner.dart';
import 'package:flutter_pirinku/widgets/section_header.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Model for a checked-out cart item passed from CartPage.
class CheckoutItem {
  final String name;
  final double price;
  final String? imageUrl;
  final int quantity;
  final String storeName;

  const CheckoutItem({
    required this.name,
    required this.price,
    this.imageUrl,
    required this.quantity,
    required this.storeName,
  });
}

class CheckoutPage extends StatelessWidget {
  final List<CheckoutItem> items;

  const CheckoutPage({super.key, required this.items});

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

  double _totalPrice() {
    return items.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  int _totalProducts() {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    final total = _totalPrice();
    final productCount = _totalProducts();

    // Group items by store
    final Map<String, List<CheckoutItem>> grouped = {};
    for (final item in items) {
      grouped.putIfAbsent(item.storeName, () => []).add(item);
    }

    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Stack(
        children: [
          // ── Scrollable body ──────────────────────────────────────────────
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 97, bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Banner
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: CheckoutInfoBanner(
                    message:
                        'Setiap pembelian barang akan di masukan ke laporan dana bulanan',
                  ),
                ),

                // ── Address & Store section ─────────────────────────────
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 24,
                        offset: Offset(0, -4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Container(
                    color: lightBackgroundColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name & Phone
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/warung/lokasi.svg',
                                  width: 18,
                                  height: 18,
                                  colorFilter: ColorFilter.mode(
                                    primaryGreenColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 9),
                                Text(
                                  'Renata',
                                  style: TextStyle(
                                    color: txtPrimary,
                                    fontSize: 16,
                                    fontFamily: visbyRoundCF,
                                    fontWeight: semiBold,
                                    height: 0.88,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '(+62) 899-1567-4235',
                              style: TextStyle(
                                color: const Color(0xFFAFAFAF),
                                fontSize: 14,
                                fontFamily: visbyRoundCF,
                                fontWeight: semiBold,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Address
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Kost biru, Jalan Yon Armed 29, rt.6/rw.14, Trihanggo, Gamping, Kab. Sleman, DI Yogyakarta, ID 55234',
                                style: TextStyle(
                                  color: txtPrimary,
                                  fontSize: 12,
                                  fontFamily: visbyRoundCF,
                                  fontWeight: semiBold,
                                  height: 1.33,
                                ),
                              ),
                            ),
                            const SizedBox(width: 18),
                            Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: txtSecondary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Store name
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/warung/warung.svg',
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                txtPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              grouped.keys.isNotEmpty
                                  ? grouped.keys.first
                                  : 'Warung',
                              style: TextStyle(
                                color: txtPrimary,
                                fontSize: 14,
                                fontFamily: visbyRoundCF,
                                fontWeight: semiBold,
                                height: 1.71,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Product list
                        ...items.map((item) => _buildProductRow(item)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 2),

                // ── Delivery Options ────────────────────────────────────
                Container(
                  color: lightBackgroundColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: 'Opsi Pengiriman',
                        onActionTap: () {},
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Instans',
                            style: TextStyle(
                              color: txtPrimary,
                              fontSize: 12,
                              fontFamily: visbyRoundCF,
                              fontWeight: bold,
                              height: 2,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Rp2000',
                                style: TextStyle(
                                  color: const Color(0xFFAFAFAF),
                                  fontSize: 12,
                                  fontFamily: visbyRoundCF,
                                  fontWeight: medium,
                                  decoration: TextDecoration.lineThrough,
                                  height: 2,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.local_offer_outlined,
                                size: 18,
                                color: primaryGreenColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Pengiriman akan langsung di lakukan oleh penjual',
                        style: TextStyle(
                          color: txtPrimary,
                          fontSize: 12,
                          fontFamily: visbyRoundCF,
                          fontWeight: medium,
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 2),

                // ── Payment Method ──────────────────────────────────────
                Container(
                  color: lightBackgroundColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: 'Metode Pembayaran',
                        onActionTap: () {},
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Transfer Bank - Bank Mandiri',
                            style: TextStyle(
                              color: bgRedColor,
                              fontSize: 12,
                              fontFamily: visbyRoundCF,
                              fontWeight: medium,
                              height: 2,
                            ),
                          ),
                          // Mandiri logo placeholder
                          Container(
                            width: 58,
                            height: 39,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(238, 96, 85, 0.08),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                'mandiri',
                                style: TextStyle(
                                  color: const Color(0xFFEE6055),
                                  fontSize: 10,
                                  fontFamily: visbyRoundCF,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total $productCount Produk',
                            style: TextStyle(
                              color: txtPrimary,
                              fontSize: 14,
                              fontFamily: visbyRoundCF,
                              fontWeight: medium,
                              height: 1.71,
                            ),
                          ),
                          Text(
                            'Rp${_formatPrice(total)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: txtPrimary,
                              fontSize: 12,
                              fontFamily: visbyRoundCF,
                              fontWeight: semiBold,
                              height: 2,
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

          // ── Fixed Header ─────────────────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: lightBackgroundColor,
              padding: const EdgeInsets.only(
                top: 55,
                left: 16,
                right: 16,
                bottom: 12,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/icons/icon_back.svg',
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Checkout',
                    style: TextStyle(
                      color: txtPrimary,
                      fontSize: 22,
                      fontFamily: visbyRoundCF,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Fixed Bottom Bar ─────────────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: lightBackgroundColor,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 24,
                    offset: Offset(0, -4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Total price label
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Total ',
                          style: TextStyle(
                            color: txtPrimary,
                            fontSize: 14,
                            fontFamily: visbyRoundCF,
                            fontWeight: semiBold,
                            height: 1.71,
                          ),
                        ),
                        TextSpan(
                          text: 'Rp${_formatPrice(total)}',
                          style: TextStyle(
                            color: primaryGreenColor,
                            fontSize: 14,
                            fontFamily: visbyRoundCF,
                            fontWeight: semiBold,
                            height: 1.71,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Buat Pesanan button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderSuccessPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: ShapeDecoration(
                        color: primaryGreenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: Text(
                        'Buat Pesanan',
                        style: TextStyle(
                          color: txtWhite,
                          fontSize: 14,
                          fontFamily: visbyRoundCF,
                          fontWeight: semiBold,
                          height: 1.71,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(CheckoutItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image box
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
            child: item.imageUrl != null
                ? Image.network(
                    item.imageUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.shopping_bag_outlined,
                      color: txtSecondary,
                      size: 40,
                    ),
                  )
                : Icon(
                    Icons.shopping_bag_outlined,
                    color: txtSecondary,
                    size: 40,
                  ),
          ),
          const SizedBox(width: 18),

          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    color: txtPrimary,
                    fontSize: 12,
                    fontFamily: visbyRoundCF,
                    fontWeight: semiBold,
                    height: 2,
                  ),
                ),
                Text(
                  'Rp${_formatPrice(item.price)}',
                  style: TextStyle(
                    color: txtPrimary,
                    fontSize: 12,
                    fontFamily: visbyRoundCF,
                    fontWeight: medium,
                    height: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.quantity}x',
                  style: TextStyle(
                    color: txtPrimary,
                    fontSize: 12,
                    fontFamily: visbyRoundCF,
                    fontWeight: medium,
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
