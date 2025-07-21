import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final TextEditingController ingredientController = TextEditingController();
  final List<String> allIngredients = [
    'Ayam',
    'Nasi',
    'Mie',
    'Telur',
    'Cabe',
    'Daging',
    'Tahu',
    'Tempe'
  ];
  List<String> selectedIngredients = [];
  List<String> filteredIngredients = [];

  @override
  void initState() {
    super.initState();
    filteredIngredients = allIngredients;
  }

  void onSearchChanged(String query) {
    setState(() {
      filteredIngredients = allIngredients
          .where((item) => item.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  void onAddIngredient(String ingredient) {
    if (ingredient.isEmpty) return;
    if (!selectedIngredients.contains(ingredient)) {
      setState(() {
        selectedIngredients.add(ingredient);
        ingredientController.clear();
        filteredIngredients = allIngredients;
      });
    }
  }

  void onRemoveIngredient(String ingredient) {
    setState(() {
      selectedIngredients.remove(ingredient);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Atur Makanmu'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Rencanain makan enak tanpa boncos',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24),
          // Dana
          Text('Input Dana',
              style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43B275),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Bulanan',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCBCBCB),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Mingguan',
                    style: TextStyle(color: Color(0xFF252525))),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: '900.000',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF43B275)),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          // Tambahkan Bahan Favorit
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tambahkan Bahan Favorit',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              IconButton(
                icon: const Icon(Icons.add, color: Color(0xFF43B275)),
                onPressed: () {
                  if (ingredientController.text.isNotEmpty) {
                    onAddIngredient(ingredientController.text);
                  }
                },
              ),
            ],
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: selectedIngredients.map((ingredient) {
              return Chip(
                label: Text(ingredient),
                backgroundColor: const Color(0xFFCAEDD9),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => onRemoveIngredient(ingredient),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: ingredientController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Contoh: Ayam, Nasi',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF43B275)),
              ),
            ),
          ),
          if (ingredientController.text.isNotEmpty &&
              filteredIngredients.isNotEmpty)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: filteredIngredients.map((ingredient) {
                return GestureDetector(
                  onTap: () => onAddIngredient(ingredient),
                  child: Chip(
                    label: Text(ingredient),
                    backgroundColor: const Color(0xFFCAEDD9),
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: 24),
          // Jadwal Makan (dummy)
          const Text('Atur Jadwal Makan',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            children: [
              Chip(
                  label: Text('09.40'),
                  backgroundColor: const Color(0xFFCAEDD9)),
              Chip(
                  label: Text('19.20'),
                  backgroundColor: const Color(0xFFCAEDD9)),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF43B275),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
