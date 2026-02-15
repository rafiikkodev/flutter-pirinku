import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/widgets/order_status_item.dart';
import 'package:flutter_pirinku/widgets/search_bar_widget.dart' as custom;
import 'package:flutter_pirinku/widgets/category_icon.dart';
import 'package:flutter_pirinku/widgets/product_card.dart';
import 'package:flutter_pirinku/widgets/warung_card.dart';
import 'package:flutter_pirinku/pages/product_detail_page.dart';
import 'package:flutter_pirinku/pages/warung_detail_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WarungPage extends StatefulWidget {
  const WarungPage({super.key});

  @override
  State<WarungPage> createState() => _WarungPageState();
}

class _WarungPageState extends State<WarungPage> {
  // Sample data for categories
  final List<Map<String, String?>> categories = [
    {'image': 'assets/warung/sayuran.png', 'label': 'Sayuran'},
    {'image': 'assets/warung/karbo.png', 'label': 'Karbo'},
    {'image': 'assets/warung/bumbu.png', 'label': 'Bumbu'},
    {'image': 'assets/warung/protein.png', 'label': 'Protein'},
    {'image': 'assets/warung/cepat saji.png', 'label': 'Cepat Saji'},
  ];

  // Sample data for popular products
  final List<Map<String, dynamic>> popularProducts = [
    {
      'image': null,
      'name': 'ABC SARDINES EXTRA HOT',
      'price': 'Rp 12.000',
      'calories': '23 Kkal',
      'weight': '155 Gr',
    },
    {
      'image': null,
      'name': 'NUGGET AYAM SO ECO',
      'price': 'Rp 12.000',
      'calories': '23 Kkal',
      'weight': '155 Gr',
    },
    {
      'image': null,
      'name': 'INDOMIE GORENG PEDAS',
      'price': 'Rp 3.500',
      'calories': '23 Kkal',
      'weight': '155 Gr',
    },
  ];

  // Sample data for nearby stores
  final List<Map<String, dynamic>> nearbyStores = [
    {
      'image': null,
      'name': 'Warung Bu Yani',
      'rating': 4.0,
      'reviewCount': 120,
      'isOpen': true,
      'closingTime': '15.00',
    },
    {
      'image': null,
      'name': 'Kirana Mart',
      'rating': 4.0,
      'reviewCount': 85,
      'isOpen': true,
      'closingTime': '22.00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildHeader(),
                const SizedBox(height: 24),
                _buildOrderStatus(),
                const SizedBox(height: 24),
                _buildSearchBar(),
                const SizedBox(height: 24),
                _buildCategories(),
                const SizedBox(height: 24),
                _buildPopularSection(),
                const SizedBox(height: 24),
                _buildNearbyStoresSection(),
                const SizedBox(height: 100), // Space for bottom navigation
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Warung Kos',
              style: TextStyle(
                color: txtPrimary,
                fontSize: 22,
                fontFamily: 'Visby Round CF',
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Belanja Hemat',
              style: TextStyle(
                color: txtPrimary,
                fontSize: 14,
                fontFamily: 'Visby Round CF',
                fontWeight: medium,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                // Handle location
              },
              icon: SvgPicture.asset(
                'assets/warung/lokasi.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(txtPrimary, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 6),
            IconButton(
              onPressed: () {
                // Handle cart
              },
              icon: SvgPicture.asset(
                'assets/warung/troli.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(txtPrimary, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OrderStatusItem(
          svgIcon: 'assets/warung/belum bayar.svg',
          label: 'Belum Bayar',
          onTap: () {
            // Handle belum bayar
          },
        ),
        OrderStatusItem(
          svgIcon: 'assets/warung/dikemas.svg',
          label: 'Dikemas',
          onTap: () {
            // Handle dikemas
          },
        ),
        OrderStatusItem(
          svgIcon: 'assets/warung/dikirim.svg',
          label: 'Dikirim',
          hasNotification: true,
          onTap: () {
            // Handle dikirim
          },
        ),
        OrderStatusItem(
          svgIcon: 'assets/warung/beri nilai.svg',
          label: 'Beri Nilai',
          onTap: () {
            // Handle beri nilai
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return custom.SearchBar(
      hintText: 'Cari sayur atau bumbu…',
      readOnly: true,
      onTap: () {
        // Navigate to search page
      },
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryIcon(
            imageUrl: category['image'],
            label: category['label'] ?? '',
            onTap: () {
              // Show feedback when category is tapped
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Kategori ${category['label']} dipilih'),
                  duration: const Duration(seconds: 1),
                  backgroundColor: primaryGreenColor,
                ),
              );
              // TODO: Navigate to category page with filtered products
            },
          );
        },
      ),
    );
  }

  Widget _buildPopularSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Populer',
              style: TextStyle(
                color: txtPrimary,
                fontSize: 18,
                fontFamily: 'Visby Round CF',
                fontWeight: semiBold,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to see all popular
              },
              child: Text(
                'Lihat semua',
                style: TextStyle(
                  color: primaryGreenColor,
                  fontSize: 14,
                  fontFamily: 'Visby Round CF',
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: popularProducts.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final product = popularProducts[index];
              return ProductCard(
                imageUrl: product['image'],
                title: product['name'],
                price: product['price'],
                calories: product['calories'],
                weight: product['weight'],
                onAdd: () {
                  // Quick add to cart
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        productName: product['name'],
                        imageUrl: product['image'],
                        originalPrice: 12960,
                        discountedPrice: 10886,
                        discountPercent: 16,
                        storeName: 'Warung Bu Yani',
                      ),
                    ),
                  );
                },
                onTap: () {
                  // Navigate to product detail
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        productName: product['name'],
                        imageUrl: product['image'],
                        originalPrice: 12960,
                        discountedPrice: 10886,
                        discountPercent: 16,
                        storeName: 'Warung Bu Yani',
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNearbyStoresSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Warung terdekat',
              style: TextStyle(
                color: txtPrimary,
                fontSize: 18,
                fontFamily: 'Visby Round CF',
                fontWeight: semiBold,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to see all stores
              },
              child: Text(
                'Lihat Semua',
                style: TextStyle(
                  color: primaryGreenColor,
                  fontSize: 14,
                  fontFamily: 'Visby Round CF',
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: nearbyStores.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final store = nearbyStores[index];
              return SizedBox(
                width: 300,
                child: WarungCard(
                  imageUrl: store['image'],
                  name: store['name'],
                  rating: store['rating'],
                  reviewCount: store['reviewCount'],
                  isOpen: store['isOpen'],
                  closingTime: store['closingTime'],
                  onTap: () {
                    // Navigate to store detail
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WarungDetailPage(
                          imageUrl: store['image'],
                          name: store['name'],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
