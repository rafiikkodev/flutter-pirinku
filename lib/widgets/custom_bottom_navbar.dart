import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/pages/schedule_page.dart';
import 'package:get/get.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        onTap(index);
        switch (index) {
          case 0:
            Get.toNamed('/home');
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SchedulePage()),
            );
            break;
          case 2:
            Get.toNamed('/garpi');
            break;
          case 3:
            Get.toNamed('/warung');
            break;
          case 4:
            Get.toNamed('/media');
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryGreenColor,
      unselectedItemColor: txtPrimary.withOpacity(0.5),
      selectedLabelStyle: primaryTextStyle.copyWith(
        fontSize: 12,
        fontWeight: semiBold,
      ),
      unselectedLabelStyle: primaryTextStyle.copyWith(
        fontSize: 12,
        fontWeight: medium,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Jadwal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          label: 'Garpi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.storefront),
          label: 'Warung',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library),
          label: 'Media',
        ),
      ],
    );
  }
}
