import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/widgets/button_large_primary.dart';

class CookingToolPage extends StatefulWidget {
  const CookingToolPage({super.key});

  @override
  State<CookingToolPage> createState() => _CookingToolPageState();
}

class _CookingToolPageState extends State<CookingToolPage> {
  final TextEditingController toolController = TextEditingController();
  final List<String> allTools = [
    'Kompor',
    'Rice Cooker',
    'Panci',
    'Teflon',
    'Wajan',
    'Talenan',
    'Pisau',
    'Sendok',
    'Garpu',
    'Piring',
    'Gelas',
    'Sutil',
    'Mangkuk',
    'Spatula',
    'Saringan',
    'Loyang',
    'Microwave',
    'Ketel Listrik',
    'Teko',
  ];
  List<String> selectedTools = [];
  List<String> filteredTools = [];

  @override
  void initState() {
    super.initState();
    filteredTools = allTools;
  }

  void onSearchChanged(String query) {
    setState(() {
      filteredTools = allTools
          .where((tool) => tool.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  void onAddTool(String tool) {
    if (tool.isEmpty) return;
    if (!selectedTools.contains(tool)) {
      setState(() {
        selectedTools.add(tool);
        toolController.clear();
        filteredTools = allTools;
      });
    }
  }

  void onRemoveTool(String tool) {
    setState(() {
      selectedTools.remove(tool);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Text(
              'Alat Masakmu Apa Aja?',
              style: primaryTextStyle.copyWith(
                color: txtPrimary,
                fontSize: 22,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Masukin alat yang kamu punya, biar resepnya pas',
              style: primaryTextStyle.copyWith(
                color: txtPrimary,
                fontSize: 14,
                fontWeight: medium,
              ),
            ),
            const SizedBox(height: 25),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: selectedTools.map((tool) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: chipColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tool,
                        style: primaryTextStyle.copyWith(
                          color: txtPrimary,
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => onRemoveTool(tool),
                        child: Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            color: bgRedColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close, size: 12, color: txtWhite),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 15),
            Text(
              'Ketik alat masakmu di sini',
              style: primaryTextStyle.copyWith(
                color: txtPrimary,
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: toolController,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Contoh: Kompor, Panci',
                hintStyle: primaryTextStyle.copyWith(
                  color: txtPrimary.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: medium,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: primaryGreenColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: primaryGreenColor, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (toolController.text.isNotEmpty && filteredTools.isNotEmpty)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: filteredTools.map((tool) {
                  return GestureDetector(
                    onTap: () => onAddTool(tool),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: chipColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tool,
                        style: primaryTextStyle.copyWith(
                          color: txtPrimary,
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFEE6055),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 24,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Alat-alatmu bakal aku inget buat\nresep',
                      style: primaryTextStyle.copyWith(
                        color: txtWhite,
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: "Lanjut",
              onPressed: () {
                Navigator.pushNamed(context, "/homepage");
              },
            ),
          ],
        ),
      ),
    );
  }
}
