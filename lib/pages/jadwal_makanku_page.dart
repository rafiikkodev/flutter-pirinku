import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:get/get.dart';

final bgWhite = const Color(0xFFFFFFFF);

class JadwalMakankuPage extends StatefulWidget {
  const JadwalMakankuPage({super.key});

  @override
  State<JadwalMakankuPage> createState() => _JadwalMakankuPageState();
}

class _JadwalMakankuPageState extends State<JadwalMakankuPage> {
  int selectedDateIndex = 2; // Today is selected by default
  List<Map<String, String>> dates = [];
  String currentYear = '';
  int? selectedMealIndex; // Tracks which meal card is selected
  Set<int> editedMeals = {}; // Tracks which meals have been edited

  @override
  void initState() {
    super.initState();
    _generateDates();
  }

  void _generateDates() {
    final now = DateTime.now();
    currentYear = now.year.toString();

    // Generate 5 dates: 2 days before today, today, 2 days after today
    dates.clear();
    for (int i = -2; i <= 2; i++) {
      final date = now.add(Duration(days: i));
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'Mei',
        'Jun',
        'Jul',
        'Agu',
        'Sep',
        'Okt',
        'Nov',
        'Des',
      ];
      dates.add({
        'month': months[date.month - 1],
        'day': date.day.toString().padLeft(2, '0'),
        'dayName': _getDayName(date.weekday),
      });
    }
    selectedDateIndex = 2; // Today is in the middle
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Sen';
      case 2:
        return 'Sel';
      case 3:
        return 'Rab';
      case 4:
        return 'Kam';
      case 5:
        return 'Jum';
      case 6:
        return 'Sab';
      case 7:
        return 'Min';
      default:
        return '';
    }
  }

  final List<Map<String, dynamic>> mealSchedule = [
    {'type': 'water', 'title': 'Minum Air Putih', 'time': '08.00'},
    {'type': 'water', 'title': 'Minum Air Putih', 'time': '09.00'},
    {
      'type': 'meal',
      'title': 'Sarapan',
      'recipe': 'Ayam Goreng Sambel Ijo',
      'price': 'Rp12.000',
      'time': '09.40',
    },
    {'type': 'water', 'title': 'Minum Air Putih', 'time': '11.00'},
    {'type': 'water', 'title': 'Minum Air Putih', 'time': '13.00'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhite,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.arrow_back, color: txtPrimary),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Jadwal Makanku',
                        style: TextStyle(
                          fontFamily: 'Visby Round CF',
                          fontSize: 22,
                          fontWeight: semiBold,
                          color: txtPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Year
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      currentYear,
                      style: TextStyle(
                        fontFamily: 'Visby Round CF',
                        fontSize: 22,
                        fontWeight: semiBold,
                        color: txtPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Date Selector (Horizontal Scroll)
                SizedBox(
                  height: 81,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: dates.length,
                    itemBuilder: (context, index) {
                      final date = dates[index];
                      final isSelected = index == selectedDateIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDateIndex = index;
                          });
                        },
                        child: Container(
                          width: 63,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? primaryGreenColor
                                : const Color(0xFFCAEDD9),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x19000000),
                                blurRadius: 24,
                                offset: const Offset(0, -4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                date['month']!,
                                style: TextStyle(
                                  fontFamily: 'Visby Round CF',
                                  fontSize: 12,
                                  fontWeight: bold,
                                  color: txtWhite,
                                ),
                              ),
                              Text(
                                date['day']!,
                                style: TextStyle(
                                  fontFamily: 'Visby Round CF',
                                  fontSize: 18,
                                  fontWeight: bold,
                                  color: txtWhite,
                                ),
                              ),
                              Text(
                                date['dayName']!,
                                style: TextStyle(
                                  fontFamily: 'Visby Round CF',
                                  fontSize: 12,
                                  fontWeight: bold,
                                  color: txtWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),

                // Meal Schedule List (Vertical Scroll)
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: mealSchedule.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                      final item = mealSchedule[index];
                      if (item['type'] == 'water') {
                        return _buildWaterItem(item);
                      } else {
                        return _buildMealItem(item, index);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 80), // Space for save button and nav
              ],
            ),

            // Save Button (Floating) - Only show when no card is selected
            if (selectedMealIndex == null)
              Positioned(
                left: 16,
                right: 16,
                bottom: 100,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: primaryGreenColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x19000000),
                        blurRadius: 24,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.snackbar(
                        'Berhasil',
                        'Jadwal makan berhasil disimpan!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: primaryGreenColor,
                        colorText: txtWhite,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreenColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Simpan',
                      style: TextStyle(
                        fontFamily: 'Visby Round CF',
                        fontSize: 14,
                        fontWeight: semiBold,
                        color: txtWhite,
                      ),
                    ),
                  ),
                ),
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

  Widget _buildWaterItem(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCDCDCD)),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
        color: bgWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['title'],
                style: TextStyle(
                  fontFamily: 'Visby Round CF',
                  fontSize: 16,
                  fontWeight: semiBold,
                  color: txtPrimary,
                ),
              ),
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.delete_outline,
                  size: 16,
                  color: txtSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: txtPrimary),
              const SizedBox(width: 6),
              Text(
                item['time'],
                style: TextStyle(
                  fontFamily: 'Visby Round CF',
                  fontSize: 14,
                  fontWeight: medium,
                  color: txtPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMealItem(Map<String, dynamic> item, int index) {
    final isSelected = selectedMealIndex == index;
    final isEdited = editedMeals.contains(index);

    return GestureDetector(
      onTap: () {
        setState(() {
          // Toggle selection
          if (selectedMealIndex == index) {
            selectedMealIndex = null;
          } else {
            selectedMealIndex = index;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          border: Border.all(color: primaryGreenColor),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color(0x19000000),
              blurRadius: 24,
              offset: const Offset(0, -4),
            ),
          ],
          color: bgWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['title'],
                  style: TextStyle(
                    fontFamily: 'Visby Round CF',
                    fontSize: 16,
                    fontWeight: semiBold,
                    color: txtPrimary,
                  ),
                ),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    size: 16,
                    color: txtSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              item['recipe'],
              style: TextStyle(
                fontFamily: 'Visby Round CF',
                fontSize: 16,
                fontWeight: semiBold,
                color: txtPrimary,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.attach_money, size: 14, color: txtPrimary),
                const SizedBox(width: 5),
                Text(
                  item['price'],
                  style: TextStyle(
                    fontFamily: 'Visby Round CF',
                    fontSize: 14,
                    fontWeight: medium,
                    color: txtPrimary,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.access_time, size: 16, color: txtPrimary),
                const SizedBox(width: 5),
                Text(
                  item['time'],
                  style: TextStyle(
                    fontFamily: 'Visby Round CF',
                    fontSize: 14,
                    fontWeight: medium,
                    color: txtPrimary,
                  ),
                ),
              ],
            ),

            // Only show button when card is selected
            if (isSelected) ...[
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  if (isEdited) {
                    // Show recipe details
                    _showRecipeDetailsDialog(index);
                  } else {
                    // Show edit recipe modal
                    _showChangeRecipeDialog(index);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: primaryGreenColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isEdited ? Icons.visibility : Icons.edit,
                        size: 20,
                        color: txtWhite,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isEdited ? 'Lihat Resep' : 'Ubah Resep',
                        style: TextStyle(
                          fontFamily: 'Visby Round CF',
                          fontSize: 14,
                          fontWeight: medium,
                          color: txtWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showChangeRecipeDialog(int index) {
    final TextEditingController recipeController = TextEditingController(
      text: mealSchedule[index]['recipe'],
    );
    final TextEditingController priceController = TextEditingController(
      text: mealSchedule[index]['price'].replaceAll('Rp', ''),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Ubah Resep',
          style: TextStyle(fontFamily: 'Visby Round CF', fontWeight: semiBold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: recipeController,
              decoration: InputDecoration(
                labelText: 'Nama Resep',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: primaryGreenColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga',
                prefixText: 'Rp',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: primaryGreenColor, width: 2),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: txtSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                mealSchedule[index]['recipe'] = recipeController.text;
                mealSchedule[index]['price'] = 'Rp${priceController.text}';
                // Mark this meal as edited
                editedMeals.add(index);
                // Deselect the card
                selectedMealIndex = null;
              });
              Navigator.pop(context);
              Get.snackbar(
                'Berhasil',
                'Resep berhasil diubah!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: primaryGreenColor,
                colorText: txtWhite,
                margin: const EdgeInsets.all(16),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: primaryGreenColor),
            child: Text('Simpan', style: TextStyle(color: txtWhite)),
          ),
        ],
      ),
    );
  }

  void _showRecipeDetailsDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Detail Resep',
          style: TextStyle(fontFamily: 'Visby Round CF', fontWeight: semiBold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Resep',
              style: TextStyle(
                fontFamily: 'Visby Round CF',
                fontSize: 12,
                fontWeight: medium,
                color: txtSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              mealSchedule[index]['recipe'],
              style: TextStyle(
                fontFamily: 'Visby Round CF',
                fontSize: 16,
                fontWeight: semiBold,
                color: txtPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Harga',
              style: TextStyle(
                fontFamily: 'Visby Round CF',
                fontSize: 12,
                fontWeight: medium,
                color: txtSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              mealSchedule[index]['price'],
              style: TextStyle(
                fontFamily: 'Visby Round CF',
                fontSize: 16,
                fontWeight: semiBold,
                color: txtPrimary,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: primaryGreenColor),
            child: Text('Tutup', style: TextStyle(color: txtWhite)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: bgWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, 'Beranda', false, '/beranda'),
              _buildNavItem(
                Icons.calendar_today_outlined,
                'Jadwal',
                true,
                '/jadwal',
              ),
              _buildNavItem(Icons.store_outlined, 'Warung', false, '/warung'),
              _buildNavItem(
                Icons.video_library_outlined,
                'Media',
                false,
                '/media',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    String route,
  ) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          Get.toNamed(route);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? primaryGreenColor : txtSecondary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Visby Round CF',
              fontSize: 12,
              color: isActive ? primaryGreenColor : txtSecondary,
              fontWeight: isActive ? semiBold : regular,
            ),
          ),
        ],
      ),
    );
  }
}
