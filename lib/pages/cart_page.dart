import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/pages/checkout_page.dart';
import 'package:flutter_pirinku/widgets/cart_item_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const CartPage({super.key, required this.items});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, List<CartItem>> storeItems = {};
  Map<String, bool> storeSelected = {};
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    _groupItemsByStore();
  }

  void _groupItemsByStore() {
    for (var item in widget.items) {
      final storeName = item['storeName'] as String? ?? 'Toko Tidak Diketahui';
      if (!storeItems.containsKey(storeName)) {
        storeItems[storeName] = [];
        storeSelected[storeName] = false;
      }
      storeItems[storeName]!.add(
        CartItem(
          name: item['name'] as String? ?? 'Produk',
          price: (item['price'] as num?)?.toDouble() ?? 0.0,
          image: item['image'] as String?,
          quantity: item['quantity'] as int? ?? 1,
          isSelected: false,
        ),
      );
    }
  }

  void _toggleSelectAll() {
    setState(() {
      selectAll = !selectAll;
      for (var storeName in storeItems.keys) {
        storeSelected[storeName] = selectAll;
        for (var item in storeItems[storeName]!) {
          item.isSelected = selectAll;
        }
      }
    });
  }

  void _toggleStoreSelection(String storeName) {
    setState(() {
      storeSelected[storeName] = !storeSelected[storeName]!;
      for (var item in storeItems[storeName]!) {
        item.isSelected = storeSelected[storeName]!;
      }
      _updateSelectAll();
    });
  }

  void _toggleItemSelection(String storeName, CartItem item) {
    setState(() {
      item.isSelected = !item.isSelected;
      storeSelected[storeName] = storeItems[storeName]!.every(
        (i) => i.isSelected,
      );
      _updateSelectAll();
    });
  }

  void _updateSelectAll() {
    selectAll = storeItems.values.every(
      (items) => items.every((item) => item.isSelected),
    );
  }

  void _incrementQuantity(CartItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void _decrementQuantity(CartItem item) {
    if (item.quantity > 1) {
      setState(() {
        item.quantity--;
      });
    }
  }

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

  double _calculateTotal() {
    double total = 0;
    for (var items in storeItems.values) {
      for (var item in items) {
        if (item.isSelected) {
          total += item.price * item.quantity;
        }
      }
    }
    return total;
  }

  int _getSelectedCount() {
    int count = 0;
    for (var items in storeItems.values) {
      for (var item in items) {
        if (item.isSelected) {
          count += item.quantity;
        }
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      bottomNavigationBar: _buildBottomBar(),
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 107, bottom: 55),
            child: Column(
              children: [
                ...storeItems.entries.map(
                  (entry) => _buildStoreSection(entry.key, entry.value),
                ),
              ],
            ),
          ),
          // Fixed header
          _buildHeader(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(
          top: 55,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(color: lightBackgroundColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset('assets/icons/icon_back.svg'),
                ),
                const SizedBox(width: 10),
                Text(
                  'Keranjang Saya',
                  style: TextStyle(
                    color: txtPrimary,
                    fontSize: 22,
                    fontFamily: 'Visby Round CF',
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreSection(String storeName, List<CartItem> items) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 8),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _toggleStoreSelection(storeName),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: ShapeDecoration(
                        color: storeSelected[storeName]!
                            ? primaryGreenColor
                            : lightBackgroundColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: storeSelected[storeName]!
                                ? primaryGreenColor
                                : txtPrimary,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: storeSelected[storeName]!
                          ? Icon(Icons.check, size: 16, color: txtWhite)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  SvgPicture.asset(
                    'assets/warung/warung.svg',
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(txtPrimary, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    storeName,
                    style: TextStyle(
                      color: txtPrimary,
                      fontSize: 14,
                      fontFamily: 'Visby Round CF',
                      fontWeight: semiBold,
                      height: 1.71,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.chevron_right, size: 14, color: txtSecondary),
                ],
              ),
              Text(
                'Ubah',
                style: TextStyle(
                  color: txtPrimary,
                  fontSize: 12,
                  fontFamily: 'Visby Round CF',
                  fontWeight: medium,
                  height: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 27),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CartItemWidget(
                productName: item.name,
                price: item.price,
                imageUrl: item.image,
                quantity: item.quantity,
                isSelected: item.isSelected,
                onToggleSelect: () => _toggleItemSelection(storeName, item),
                onIncrement: () => _incrementQuantity(item),
                onDecrement: () => _decrementQuantity(item),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final total = _calculateTotal();
    final selectedCount = _getSelectedCount();

    return Container(
      margin: const EdgeInsets.only(bottom: 55),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Voucher section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: ShapeDecoration(
              color: lightBackgroundColor,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFCBCBCB)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/warung/voucher.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        txtPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Voucher Pirinku',
                      style: TextStyle(
                        color: txtPrimary,
                        fontSize: 11,
                        fontFamily: 'Visby Round CF',
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Gunakan/masukan kode',
                      style: TextStyle(
                        color: const Color(0xFFAFAFAF),
                        fontSize: 10,
                        fontFamily: 'Visby Round CF',
                        fontWeight: semiBold,
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 14, color: txtSecondary),
                  ],
                ),
              ],
            ),
          ),
          // Checkout section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: lightBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: _toggleSelectAll,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: ShapeDecoration(
                          color: selectAll
                              ? primaryGreenColor
                              : lightBackgroundColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: selectAll ? primaryGreenColor : txtPrimary,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: selectAll
                            ? Icon(Icons.check, size: 16, color: txtWhite)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Semua',
                      style: TextStyle(
                        color: txtPrimary,
                        fontSize: 14,
                        fontFamily: 'Visby Round CF',
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Total ',
                            style: TextStyle(
                              color: txtPrimary,
                              fontSize: 12,
                              fontFamily: 'Visby Round CF',
                              fontWeight: semiBold,
                            ),
                          ),
                          TextSpan(
                            text: 'Rp${_formatPrice(total)}',
                            style: TextStyle(
                              color: primaryGreenColor,
                              fontSize: 12,
                              fontFamily: 'Visby Round CF',
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: selectedCount > 0
                          ? () {
                              // Collect all selected items and navigate to CheckoutPage
                              final selectedItems = <CheckoutItem>[];
                              storeItems.forEach((storeName, items) {
                                for (final item in items) {
                                  if (item.isSelected) {
                                    selectedItems.add(
                                      CheckoutItem(
                                        name: item.name,
                                        price: item.price,
                                        imageUrl: item.image,
                                        quantity: item.quantity,
                                        storeName: storeName,
                                      ),
                                    );
                                  }
                                }
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      CheckoutPage(items: selectedItems),
                                ),
                              );
                            }
                          : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: ShapeDecoration(
                          color: selectedCount > 0
                              ? primaryGreenColor
                              : txtSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: Text(
                          'Checkout ($selectedCount)',
                          style: TextStyle(
                            color: txtWhite,
                            fontSize: 12,
                            fontFamily: 'Visby Round CF',
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String name;
  final double price;
  final String? image;
  int quantity;
  bool isSelected;

  CartItem({
    required this.name,
    required this.price,
    this.image,
    required this.quantity,
    this.isSelected = false,
  });
}
