import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

final bgWhite = const Color(0xFFFFFFFF);

class JadwalMakankuPage extends StatefulWidget {
  const JadwalMakankuPage({super.key});

  @override
  State<JadwalMakankuPage> createState() => _JadwalMakankuPageState();
}

class _JadwalMakankuPageState extends State<JadwalMakankuPage> {
  int selectedDateIndex =
      15; // Today is selected by default (middle of 31 dates)
  List<Map<String, dynamic>> dates = [];
  String currentYear = '';
  int? selectedMealIndex; // Tracks which meal card is selected
  Set<int> editedMeals = {}; // Tracks which meals have been edited
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _generateDates();
    // Initialize meal schedule for today
    mealSchedule = _getMealScheduleForDate(selectedDateIndex);
    // Auto scroll to today after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        // Calculate position: each card is 63 width + 10 margin = 73 pixels
        final position = (selectedDateIndex - 2) * 73.0;
        _scrollController.animateTo(
          position,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _generateDates() {
    final now = DateTime.now();
    currentYear = now.year.toString();

    // Generate dates: 15 days before today, today, 15 days after today (total 31 days)
    dates.clear();
    for (int i = -15; i <= 15; i++) {
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
        'year': date.year.toString(),
        'fullDate': date, // Store full DateTime for accurate tracking
      });
    }
    selectedDateIndex = 15; // Today is in the middle
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

  List<Map<String, dynamic>> _getMealScheduleForDate(int dateIndex) {
    // Generate different meal schedule based on date index (dummy data)
    final baseSchedules = [
      [
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
      ],
      [
        {'type': 'water', 'title': 'Minum Air Putih', 'time': '07.30'},
        {
          'type': 'meal',
          'title': 'Sarapan',
          'recipe': 'Nasi Goreng Spesial',
          'price': 'Rp15.000',
          'time': '08.30',
        },
        {'type': 'water', 'title': 'Minum Air Putih', 'time': '10.00'},
        {
          'type': 'meal',
          'title': 'Makan Siang',
          'recipe': 'Soto Ayam',
          'price': 'Rp18.000',
          'time': '12.30',
        },
        {'type': 'water', 'title': 'Minum Air Putih', 'time': '15.00'},
      ],
      [
        {'type': 'water', 'title': 'Minum Air Putih', 'time': '07.00'},
        {
          'type': 'meal',
          'title': 'Sarapan',
          'recipe': 'Bubur Ayam',
          'price': 'Rp10.000',
          'time': '08.00',
        },
        {'type': 'water', 'title': 'Minum Air Putih', 'time': '10.30'},
        {
          'type': 'meal',
          'title': 'Makan Siang',
          'recipe': 'Nasi Padang',
          'price': 'Rp20.000',
          'time': '13.00',
        },
        {'type': 'water', 'title': 'Minum Air Putih', 'time': '16.00'},
        {
          'type': 'meal',
          'title': 'Makan Malam',
          'recipe': 'Gado-gado',
          'price': 'Rp14.000',
          'time': '19.00',
        },
      ],
    ];

    // Use modulo to cycle through different schedules
    return baseSchedules[dateIndex % baseSchedules.length];
  }

  List<Map<String, dynamic>> mealSchedule = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhite,
      body: SafeArea(
        child: Column(
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
                controller: _scrollController,
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
                        // Update meal schedule based on selected date
                        mealSchedule = _getMealScheduleForDate(index);
                        // Reset meal selection when changing date
                        selectedMealIndex = null;
                        editedMeals.clear();
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
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Show year if different from current year
                          if (date['year'] != null &&
                              date['year'] != currentYear)
                            Text(
                              date['year'] ?? '',
                              style: TextStyle(
                                fontFamily: 'Visby Round CF',
                                fontSize: 10,
                                fontWeight: semiBold,
                                color: txtWhite,
                              ),
                            ),
                          Text(
                            date['month'] ?? '',
                            style: TextStyle(
                              fontFamily: 'Visby Round CF',
                              fontSize: 12,
                              fontWeight: bold,
                              color: txtWhite,
                            ),
                          ),
                          Text(
                            date['day'] ?? '',
                            style: TextStyle(
                              fontFamily: 'Visby Round CF',
                              fontSize: 18,
                              fontWeight: bold,
                              color: txtWhite,
                            ),
                          ),
                          Text(
                            date['dayName'] ?? '',
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
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
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
                child: SvgPicture.asset(
                  'assets/jadwal/minum.svg',
                  width: 12,
                  height: 12,
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
          border: Border.all(
            color: isSelected ? primaryGreenColor : const Color(0xFFCDCDCD),
          ),
          borderRadius: BorderRadius.circular(8),
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
                  child: SvgPicture.asset(
                    'assets/jadwal/makan.svg',
                    width: 8,
                    height: 8,
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
}
