import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/widgets/menu_icon.dart';
import 'package:flutter_pirinku/widgets/schedule_card.dart';
import 'package:flutter_pirinku/widgets/food_product_card.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final PageController _bannerController = PageController();
  int _currentBannerPage = 0;

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Header
                  _buildHeader(),

                  const SizedBox(height: 40),

                  // Menu Icons
                  _buildMenuIcons(),

                  const SizedBox(height: 16),

                  // Banner Carousel
                  _buildBannerCarousel(),

                  const SizedBox(height: 16),

                  // Jadwalku Section
                  _buildJadwalkuSection(),

                  const SizedBox(height: 16),

                  // Warung Lokal Section
                  _buildWarungLokalSection(),

                  const SizedBox(height: 100), // Space for bottom nav
                ],
              ),
            ),

            // Floating Chat Button
            Positioned(
              right: 16,
              bottom: 115,
              child: _buildFloatingChatButton(),
            ),

            // Bottom Navigation
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile Picture
          Container(
            width: 49,
            height: 49,
            decoration: BoxDecoration(
              color: txtSecondary,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.network(
                'https://placehold.co/49x49',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.person, color: txtWhite, size: 24);
                },
              ),
            ),
          ),

          // Greeting
          Column(
            children: [
              Text(
                'Selamat Datang',
                style: TextStyle(
                  color: txtPrimary,
                  fontSize: 14,
                  fontFamily: 'Visby Round CF',
                  fontWeight: medium,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Renata',
                style: TextStyle(
                  color: txtPrimary,
                  fontSize: 16,
                  fontFamily: 'Visby Round CF',
                  fontWeight: semiBold,
                ),
              ),
            ],
          ),

          // Notification Bell
          Container(
            width: 49,
            height: 49,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.notifications_outlined,
                    color: txtPrimary,
                    size: 24,
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: bgRedColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuIcons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MenuIcon(
            icon: Icons.restaurant_menu,
            label: 'Jadwal',
            backgroundColor: bgRedColor,
            onTap: () => print('Jadwal'),
          ),
          MenuIcon(
            icon: Icons.shopping_basket,
            label: 'Belanja',
            backgroundColor: bgRedColor,
            onTap: () => print('Belanja'),
          ),
          MenuIcon(
            icon: Icons.book,
            label: 'Resepku',
            backgroundColor: bgRedColor,
            onTap: () => print('Resepku'),
          ),
          MenuIcon(
            icon: Icons.shopping_bag,
            label: 'Pesanan',
            backgroundColor: bgRedColor,
            onTap: () => print('Pesanan'),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return SizedBox(
      height: 119,
      child: PageView.builder(
        controller: _bannerController,
        onPageChanged: (index) {
          setState(() {
            _currentBannerPage = index;
          });
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [primaryGreenColor, secondaryGreenColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Panen sayuran\nberkualitas, Siap antar\nke rumah anda!',
                            style: TextStyle(
                              color: txtWhite,
                              fontSize: 14,
                              fontFamily: 'Visby Round CF',
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.local_florist, color: txtWhite, size: 60),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildJadwalkuSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jadwalku',
            style: TextStyle(
              color: txtPrimary,
              fontSize: 16,
              fontFamily: 'Visby Round CF',
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 191,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ScheduleCard(
                  time: '09.40',
                  message: 'Segera hidangkan\nsarapanmu',
                  imageUrl: 'https://placehold.co/100x100',
                  onTap: () => print('Schedule 1'),
                ),
                const SizedBox(width: 25),
                ScheduleCard(
                  time: '19.20',
                  message: 'Segera hidangkan\nmakan malammu',
                  imageUrl: 'https://placehold.co/100x100',
                  onTap: () => print('Schedule 2'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarungLokalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Warung Lokal',
                style: TextStyle(
                  color: txtPrimary,
                  fontSize: 16,
                  fontFamily: 'Visby Round CF',
                  fontWeight: semiBold,
                ),
              ),
              GestureDetector(
                onTap: () => print('Lihat Semua'),
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
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 198,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              FoodProductCard(
                name: 'Paket Sayur Asem',
                price: 'Rp. 6.000',
                imageUrl: 'https://placehold.co/186x132',
                onTap: () => print('Product 1'),
              ),
              const SizedBox(width: 16),
              FoodProductCard(
                name: 'Karedok',
                price: 'Rp. 12.000',
                imageUrl: 'https://placehold.co/186x132',
                onTap: () => print('Product 2'),
              ),
              const SizedBox(width: 16),
              FoodProductCard(
                name: 'Paket Sayur Sop',
                price: 'Rp. 12.000',
                imageUrl: 'https://placehold.co/186x132',
                onTap: () => print('Product 3'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingChatButton() {
    return GestureDetector(
      onTap: () => print('Chat'),
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: primaryGreenColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(Icons.chat_bubble, color: txtWhite, size: 32),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 83,
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Beranda', true),
          _buildNavItem(Icons.calendar_today, 'Jadwal', false),
          _buildNavItem(Icons.store, 'Warung', false),
          _buildNavItem(Icons.person, 'Media', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () => print(label),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? thirtyGreenColor : txtSecondary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? thirtyGreenColor : txtSecondary,
              fontSize: 12,
              fontFamily: 'Visby Round CF',
              fontWeight: isActive ? bold : medium,
            ),
          ),
        ],
      ),
    );
  }
}
