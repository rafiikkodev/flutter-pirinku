import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/widgets/category_icon.dart';
import 'package:flutter_pirinku/widgets/warung_action_button.dart';
import 'package:flutter_pirinku/widgets/warung_product_card.dart';
import 'package:flutter_pirinku/widgets/search_bar_widget.dart' as custom;

class WarungDetailPage extends StatefulWidget {
  final String? imageUrl;
  final String name;

  const WarungDetailPage({super.key, this.imageUrl, required this.name});

  @override
  State<WarungDetailPage> createState() => _WarungDetailPageState();
}

class _WarungDetailPageState extends State<WarungDetailPage> {
  // Sample data for categories
  final List<Map<String, String?>> categories = [
    {'image': null, 'label': 'Sayuran'},
    {'image': null, 'label': 'Karbo'},
    {'image': null, 'label': 'Bumbu'},
    {'image': null, 'label': 'Protein'},
    {'image': null, 'label': 'Cepat Saji'},
  ];

  // Sample data for products
  final List<Map<String, dynamic>> products = [
    {
      'image': null,
      'name': 'ABC SARDINES EXTRA HOT 155g',
      'price': 'Rp 12.000',
      'calories': '23 Kkal',
      'weight': '155 Gr',
    },
    {
      'image': null,
      'name': 'Kentang 500g',
      'price': 'Rp 12.000',
      'calories': '23 Kkal',
      'weight': '385 Gr',
    },
    {
      'image': null,
      'name': 'ABC SARDINES EXTRA HOT 155g',
      'price': 'Rp 12.000',
      'calories': '23 Kkal',
      'weight': '155 Gr',
    },
    {
      'image': null,
      'name': 'Kentang 500g',
      'price': 'Rp 12.000',
      'calories': '23 Kkal',
      'weight': '385 Gr',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildHeader(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildCategories(),
                  const SizedBox(height: 24),
                  _buildProductGrid(),
                  const SizedBox(height: 100), // Space for bottom navigation
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      expandedHeight: 225,
      pinned: true,
      backgroundColor: primaryGreenColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: txtWhite),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined, color: txtWhite),
          onPressed: () {
            // Handle cart action
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            widget.imageUrl != null
                ? Image.network(
                    widget.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: primaryGreenColor),
                  )
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [primaryGreenColor, secondaryGreenColor],
                      ),
                    ),
                  ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            // Content (Title and Action Buttons)
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.transparent,
                        size: 32,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.name,
                          style: TextStyle(
                            color: txtWhite,
                            fontSize: 22,
                            fontFamily: 'Visby Round CF',
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        custom.SearchBar(
                          hintText: 'Cari di ${widget.name.toLowerCase()}',
                          readOnly: true,
                          onTap: () {
                            // Navigate to search page
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            WarungActionButton(
                              icon: Icons.chat_outlined,
                              label: 'Chat Penjual',
                              onTap: () {
                                // Handle chat action
                              },
                            ),
                            const SizedBox(width: 10),
                            WarungActionButton(
                              icon: Icons.favorite_border,
                              label: 'Ikuti',
                              onTap: () {
                                // Handle follow action
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 27),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryIcon(
            imageUrl: category['image'],
            label: category['label'] ?? '',
            onTap: () {
              // Navigate to category page
            },
          );
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 164 / 231,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return WarungProductCard(
          imageUrl: product['image'],
          title: product['name'],
          price: product['price'],
          calories: product['calories'],
          weight: product['weight'],
          onAdd: () {
            // Add to cart
          },
          onTap: () {
            // Navigate to product detail
          },
        );
      },
    );
  }
}
