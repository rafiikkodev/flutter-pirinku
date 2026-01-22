import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/widgets/toggle_button_group.dart';
import 'package:flutter_pirinku/widgets/removable_chip.dart';
import 'package:get/get.dart';

// Define missing color variables
final bgWhite = const Color(0xFFFFFFFF);
final strokeColor = const Color(0xFFE0E0E0);

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String selectedPeriod = 'Bulanan';
  final TextEditingController budgetController = TextEditingController(
    text: '900.000',
  );
  List<String> favoriteFoods = ['Ayam', 'Nasi', 'Mie', 'Telur', 'Cabe'];
  List<String> mealSchedules = ['09.40', '19.20'];
  bool isSaved = false;

  @override
  void dispose() {
    budgetController.dispose();
    super.dispose();
  }

  void _showAddFoodDialog() {
    final TextEditingController foodController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Tambah Bahan Favorit',
          style: TextStyle(fontFamily: 'Visby Round CF', fontWeight: semiBold),
        ),
        content: TextField(
          controller: foodController,
          decoration: InputDecoration(
            hintText: 'Nama bahan...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryGreenColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryGreenColor, width: 2),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: txtSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              if (foodController.text.isNotEmpty) {
                setState(() {
                  favoriteFoods.add(foodController.text);
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: primaryGreenColor),
            child: Text('Tambah', style: TextStyle(color: txtWhite)),
          ),
        ],
      ),
    );
  }

  void _showAddScheduleDialog() {
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Tambah Jadwal Makan',
          style: TextStyle(fontFamily: 'Visby Round CF', fontWeight: semiBold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Pilih waktu makan:'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (picked != null) {
                  selectedTime = picked;
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreenColor,
              ),
              child: Text('Pilih Waktu', style: TextStyle(color: txtWhite)),
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
              final timeString =
                  '${selectedTime.hour.toString().padLeft(2, '0')}.${selectedTime.minute.toString().padLeft(2, '0')}';
              setState(() {
                mealSchedules.add(timeString);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: primaryGreenColor),
            child: Text('Tambah', style: TextStyle(color: txtWhite)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhite,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: isSaved ? _buildSavedView() : _buildEditView(),
              ),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildEditView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          'Atur Makanmu',
          style: TextStyle(
            fontFamily: 'Visby Round CF',
            fontSize: 24,
            fontWeight: semiBold,
            color: txtPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Atur pengeluaran dan bahan favorit kamu',
          style: TextStyle(
            fontFamily: 'Visby Round CF',
            fontSize: 14,
            color: txtSecondary,
          ),
        ),
        const SizedBox(height: 24),

        // Input Dana Section
        _buildInputDanaSection(),
        const SizedBox(height: 24),

        // Tambahkan Bahan Favorit Section
        _buildFavoriteFoodsSection(),
        const SizedBox(height: 24),

        // Atur Jadwal Makan Section
        _buildMealScheduleSection(),
        const SizedBox(height: 24),

        // Save Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isSaved = true;
              });
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Simpan',
              style: TextStyle(
                fontFamily: 'Visby Round CF',
                fontSize: 16,
                fontWeight: semiBold,
                color: txtWhite,
              ),
            ),
          ),
        ),
        const SizedBox(height: 80), // Space for bottom nav
      ],
    );
  }

  Widget _buildSavedView() {
    // Calculate daily budget
    String budgetText = budgetController.text.replaceAll('.', '');
    int totalBudget = int.tryParse(budgetText) ?? 0;
    int dailyBudget = selectedPeriod == 'Bulanan'
        ? (totalBudget / 30).round()
        : (totalBudget / 7).round();
    String dailyBudgetFormatted = dailyBudget.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          'Atur Makanmu',
          style: TextStyle(
            fontFamily: 'Visby Round CF',
            fontSize: 22,
            fontWeight: semiBold,
            color: txtPrimary,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Rencanain makan enak tanpa boncos',
          style: TextStyle(
            fontFamily: 'Visby Round CF',
            fontSize: 14,
            fontWeight: medium,
            color: txtPrimary,
          ),
        ),
        const SizedBox(height: 25),

        // Dana Makan Section
        Text(
          'Dana Makan',
          style: TextStyle(
            fontFamily: 'Visby Round CF',
            fontSize: 16,
            fontWeight: semiBold,
            color: txtPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: primaryGreenColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Rp${budgetController.text}',
            style: TextStyle(
              fontFamily: 'Visby Round CF',
              fontSize: 14,
              fontWeight: semiBold,
              color: txtWhite,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Dana untuk makan setiap hari sekitar Rp$dailyBudgetFormatted',
          style: TextStyle(
            fontFamily: 'Visby Round CF',
            fontSize: 14,
            fontWeight: medium,
            color: txtPrimary,
          ),
        ),
        const SizedBox(height: 15),

        // Bahan Favorit Section
        Text(
          'Bahan Favorit',
          style: TextStyle(
            fontFamily: 'Visby Round CF',
            fontSize: 16,
            fontWeight: semiBold,
            color: txtPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: favoriteFoods.map((food) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: chipColor,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                food,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Visby Round CF',
                  fontSize: 14,
                  fontWeight: medium,
                  color: txtPrimary,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 15),

        // Jadwal Makan Section
        Text(
          'Jadwal Makan',
          style: TextStyle(
            fontFamily: 'Visby Round CF',
            fontSize: 16,
            fontWeight: semiBold,
            color: txtPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: mealSchedules.map((time) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: chipColor,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                time,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Visby Round CF',
                  fontSize: 14,
                  fontWeight: medium,
                  color: txtPrimary,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 25),

        // Edit Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isSaved = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: txtSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Edit',
              style: TextStyle(
                fontFamily: 'Visby Round CF',
                fontSize: 14,
                fontWeight: semiBold,
                color: txtPrimary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Lihat Menu Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed('/jadwal-makanku');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreenColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Lihat Menu',
              style: TextStyle(
                fontFamily: 'Visby Round CF',
                fontSize: 14,
                fontWeight: semiBold,
                color: txtWhite,
              ),
            ),
          ),
        ),
        const SizedBox(height: 80), // Space for bottom nav
      ],
    );
  }

  Widget _buildInputDanaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Input Dana',
          style: TextStyle(
            fontFamily: 'Visby Round CF',
            fontSize: 16,
            fontWeight: semiBold,
            color: txtPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ToggleButtonGroup(
          option1: 'Bulanan',
          option2: 'Mingguan',
          initialSelection: selectedPeriod,
          onSelectionChanged: (value) {
            setState(() {
              selectedPeriod = value;
            });
          },
        ),
        const SizedBox(height: 16),
        TextField(
          controller: budgetController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixText: 'Rp. ',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: strokeColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primaryGreenColor, width: 2),
            ),
          ),
          style: TextStyle(fontFamily: 'Visby Round CF', color: txtPrimary),
        ),
      ],
    );
  }

  Widget _buildFavoriteFoodsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tambahkan Bahan Favorit',
              style: TextStyle(
                fontFamily: 'Visby Round CF',
                fontSize: 16,
                fontWeight: semiBold,
                color: txtPrimary,
              ),
            ),
            GestureDetector(
              onTap: _showAddFoodDialog,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: primaryGreenColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.add, color: txtWhite, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: favoriteFoods.map((food) {
            return RemovableChip(
              label: food,
              onDelete: () {
                setState(() {
                  favoriteFoods.remove(food);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMealScheduleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Atur Jadwal Makan',
              style: TextStyle(
                fontFamily: 'Visby Round CF',
                fontSize: 16,
                fontWeight: semiBold,
                color: txtPrimary,
              ),
            ),
            GestureDetector(
              onTap: _showAddScheduleDialog,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: primaryGreenColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.add, color: txtWhite, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: mealSchedules.map((time) {
            return RemovableChip(
              label: time,
              onDelete: () {
                setState(() {
                  mealSchedules.remove(time);
                });
              },
            );
          }).toList(),
        ),
      ],
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
