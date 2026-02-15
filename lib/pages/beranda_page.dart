import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/widgets/home_menu_icon.dart';
import 'package:flutter_pirinku/widgets/schedule_card.dart';
import 'package:flutter_pirinku/widgets/food_product_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            Positioned(right: 16, bottom: 16, child: _buildFloatingAIButton()),
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
          CircleAvatar(
            radius: 24.5,
            backgroundColor: primaryGreenColor,
            backgroundImage: AssetImage('assets/beranda/pp.png'),
          ),

          // Greeting
          Container(
            width: 106,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 4,
              children: [
                SizedBox(
                  width: 106,
                  child: Text(
                    'Selamat Datang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: txtPrimary,
                      fontSize: 13,
                      fontFamily: 'Visby Round CF',
                      fontWeight: medium,
                    ),
                  ),
                ),
                SizedBox(
                  width: 106,
                  child: Text(
                    'Renata',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: txtPrimary,
                      fontSize: 16,
                      fontFamily: 'Visby Round CF',
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Notification Bell
          Container(
            width: 49,
            height: 49,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    'assets/beranda/bell.svg',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 7,
        children: [
          HomeMenuIcon(
            iconAsset: 'beranda/jadwal.svg',
            label: 'Jadwal',
            onTap: () {},
          ),
          HomeMenuIcon(
            iconAsset: 'beranda/belanja.svg',
            label: 'Belanja',
            onTap: () {},
          ),
          HomeMenuIcon(
            iconAsset: 'beranda/resepku.svg',
            label: 'Resepku',
            onTap: () {},
          ),
          HomeMenuIcon(
            iconAsset: 'beranda/pesanan.svg',
            label: 'Pesanan',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Container(
      height: 119,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/beranda/banner.png',
          width: 343,
          height: 119,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildJadwalkuSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 134,
              children: [
                Text(
                  'Jadwalku',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: txtPrimary,
                    fontSize: 16,
                    fontFamily: 'Visby Round CF',
                    fontWeight: semiBold,
                  ),
                ),
              ],
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
                  imageAsset: 'beranda/jadwalku1.png',
                  onTap: () {},
                ),
                const SizedBox(width: 25),
                ScheduleCard(
                  time: '19.20',
                  message: 'Segera hidangkan\nmakan malammu',
                  imageAsset: 'beranda/jadwalku2.png',
                  onTap: () {},
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
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: txtPrimary,
                  fontSize: 16,
                  fontFamily: 'Visby Round CF',
                  fontWeight: semiBold,
                ),
              ),
              Text(
                'Lihat Semua',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryGreenColor,
                  fontSize: 14,
                  fontFamily: 'Visby Round CF',
                  fontWeight: medium,
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
                price: 'Rp. 6000',
                imageAsset: 'beranda/warunglokal1.png',
                onTap: () {},
              ),
              const SizedBox(width: 16),
              FoodProductCard(
                name: 'Karedok',
                price: 'Rp. 12.000',
                imageAsset: 'beranda/warunglokal2.png',
                onTap: () {},
              ),
              const SizedBox(width: 16),
              FoodProductCard(
                name: 'Paket Sayur Sop',
                price: 'Rp. 12.000',
                imageAsset: 'beranda/warunglokal1.png',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingAIButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 75,
        height: 75,
        decoration: ShapeDecoration(
          color: primaryGreenColor,
          shape: OvalBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset('assets/beranda/ai.png', fit: BoxFit.contain),
        ),
      ),
    );
  }
}
