import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/pages/beranda_page.dart';
import 'package:flutter_pirinku/pages/schedule_page.dart';
import 'package:flutter_pirinku/pages/warung_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;

  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  // Pages for IndexedStack - state is preserved
  final List<Widget> _pages = const [
    BerandaPage(),
    SchedulePage(),
    WarungPage(),
    Scaffold(body: Center(child: Text('Halaman Media - Coming Soon'))),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
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
      child: SafeArea(
        top: false,
        child: Container(
          height: 83,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem('assets/navbar/house.svg', 'Beranda', 0),
              _buildNavItem('assets/navbar/jadwal.svg', 'Jadwal', 1),
              _buildNavItem('assets/navbar/warung.svg', 'Warung', 2),
              _buildNavItem('assets/navbar/media.svg', 'Media', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String svgAsset, String label, int index) {
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgAsset,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isActive ? primaryGreenColor : txtSecondary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? primaryGreenColor : txtSecondary,
                fontSize: 12,
                fontFamily: 'Visby Round CF',
                fontWeight: isActive ? semiBold : medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
