import 'package:flutter/material.dart';
import 'package:flutter_pirinku/widgets/button_card.dart';

// Contoh penggunaan ButtonCard
class ButtonCardExample extends StatelessWidget {
  const ButtonCardExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Card Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Small Badge Buttons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Primary (default)
            const Text('Primary:'),
            const SizedBox(height: 8),
            ButtonCard(
              text: 'Upgrade',
              type: ButtonCardType.primary,
              onPressed: () {
                print('Upgrade button pressed');
              },
            ),
            const SizedBox(height: 16),

            // Secondary
            const Text('Secondary:'),
            const SizedBox(height: 8),
            ButtonCard(
              text: 'New',
              type: ButtonCardType.secondary,
              onPressed: () {
                print('New button pressed');
              },
            ),
            const SizedBox(height: 16),

            // Success
            const Text('Success:'),
            const SizedBox(height: 8),
            ButtonCard(
              text: 'Active',
              type: ButtonCardType.success,
              onPressed: () {
                print('Active button pressed');
              },
            ),
            const SizedBox(height: 16),

            // Warning
            const Text('Warning:'),
            const SizedBox(height: 8),
            ButtonCard(
              text: 'Pending',
              type: ButtonCardType.warning,
              onPressed: () {
                print('Pending button pressed');
              },
            ),
            const SizedBox(height: 16),

            // Danger
            const Text('Danger:'),
            const SizedBox(height: 8),
            ButtonCard(
              text: 'Expired',
              type: ButtonCardType.danger,
              onPressed: () {
                print('Expired button pressed');
              },
            ),
            const SizedBox(height: 16),

            const Divider(),
            const SizedBox(height: 16),

            // Custom sizes
            const Text(
              'Custom Sizes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                ButtonCard(
                  text: 'Small',
                  width: 60,
                  height: 20,
                  fontSize: 8,
                  onPressed: () => print('Small'),
                ),
                const SizedBox(width: 8),
                ButtonCard(
                  text: 'Medium',
                  width: 80,
                  height: 28,
                  fontSize: 10,
                  onPressed: () => print('Medium'),
                ),
                const SizedBox(width: 8),
                ButtonCard(
                  text: 'Large',
                  width: 100,
                  height: 36,
                  fontSize: 12,
                  onPressed: () => print('Large'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Divider(),
            const SizedBox(height: 16),

            // Use case example
            const Text(
              'Use Case Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Premium Plan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Rp 99.000/bulan',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  ButtonCard(
                    text: 'Upgrade',
                    type: ButtonCardType.primary,
                    width: 70,
                    height: 24,
                    fontSize: 10,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Upgrade Premium!')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
