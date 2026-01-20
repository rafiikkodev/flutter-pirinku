import 'package:flutter/material.dart';
import 'package:flutter_pirinku/widgets/toggle_button_group.dart';

// Contoh penggunaan ToggleButtonGroup
class ToggleButtonExample extends StatefulWidget {
  const ToggleButtonExample({Key? key}) : super(key: key);

  @override
  State<ToggleButtonExample> createState() => _ToggleButtonExampleState();
}

class _ToggleButtonExampleState extends State<ToggleButtonExample> {
  String selectedPeriod = 'Bulanan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toggle Button Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Contoh 1: Bulanan vs Mingguan
            ToggleButtonGroup(
              option1: 'Bulanan',
              option2: 'Mingguan',
              initialSelection: 'Bulanan',
              onSelectionChanged: (value) {
                setState(() {
                  selectedPeriod = value;
                });
                print('Periode dipilih: $value');
              },
            ),
            const SizedBox(height: 20),
            Text('Periode yang dipilih: $selectedPeriod'),
            const SizedBox(height: 40),

            // Contoh 2: Pagi vs Malam
            ToggleButtonGroup(
              option1: 'Pagi',
              option2: 'Malam',
              initialSelection: 'Pagi',
              onSelectionChanged: (value) {
                print('Waktu dipilih: $value');
              },
            ),
          ],
        ),
      ),
    );
  }
}
