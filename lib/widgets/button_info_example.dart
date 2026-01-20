import 'package:flutter/material.dart';
import 'package:flutter_pirinku/widgets/button_info.dart';

// Contoh penggunaan ButtonInfo
class ButtonInfoExample extends StatelessWidget {
  const ButtonInfoExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Info Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Info Buttons with Icons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Price Info
            const Text('Price Info:'),
            const SizedBox(height: 8),
            ButtonInfo(
              text: 'Rp 10.000',
              icon: Icons.attach_money,
              type: ButtonInfoType.primary,
              onPressed: () {
                print('Price button pressed');
              },
            ),
            const SizedBox(height: 16),

            // Time Info
            const Text('Time Info:'),
            const SizedBox(height: 8),
            ButtonInfo(
              text: '30 menit',
              icon: Icons.access_time,
              type: ButtonInfoType.secondary,
              onPressed: () {
                print('Time button pressed');
              },
            ),
            const SizedBox(height: 16),

            // Location Info
            const Text('Location Info:'),
            const SizedBox(height: 8),
            ButtonInfo(
              text: 'Jakarta',
              icon: Icons.location_on,
              type: ButtonInfoType.success,
              onPressed: () {
                print('Location button pressed');
              },
            ),
            const SizedBox(height: 16),

            // Warning Info
            const Text('Warning Info:'),
            const SizedBox(height: 8),
            ButtonInfo(
              text: 'Stok terbatas',
              icon: Icons.warning_amber,
              type: ButtonInfoType.warning,
              onPressed: () {
                print('Warning button pressed');
              },
            ),
            const SizedBox(height: 16),

            // Danger Info
            const Text('Danger Info:'),
            const SizedBox(height: 8),
            ButtonInfo(
              text: 'Kadaluarsa',
              icon: Icons.error_outline,
              type: ButtonInfoType.danger,
              onPressed: () {
                print('Danger button pressed');
              },
            ),
            const SizedBox(height: 16),

            // Neutral Info
            const Text('Neutral Info:'),
            const SizedBox(height: 8),
            ButtonInfo(
              text: 'Info umum',
              icon: Icons.info_outline,
              type: ButtonInfoType.neutral,
              onPressed: () {
                print('Neutral button pressed');
              },
            ),
            const SizedBox(height: 16),

            const Divider(),
            const SizedBox(height: 16),

            // Without Icons
            const Text(
              'Without Icons:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ButtonInfo(
                  text: 'Rp 50.000',
                  type: ButtonInfoType.primary,
                  onPressed: () => print('No icon price'),
                ),
                ButtonInfo(
                  text: '2 jam',
                  type: ButtonInfoType.secondary,
                  onPressed: () => print('No icon time'),
                ),
                ButtonInfo(
                  text: 'Tersedia',
                  type: ButtonInfoType.success,
                  onPressed: () => print('No icon status'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Divider(),
            const SizedBox(height: 16),

            // Use Case Example
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nasi Goreng Spesial',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ButtonInfo(
                        text: 'Rp 25.000',
                        icon: Icons.payments,
                        type: ButtonInfoType.primary,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Lihat harga')),
                          );
                        },
                      ),
                      ButtonInfo(
                        text: '45 menit',
                        icon: Icons.timer,
                        type: ButtonInfoType.secondary,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Waktu masak')),
                          );
                        },
                      ),
                      ButtonInfo(
                        text: '4 porsi',
                        icon: Icons.people,
                        type: ButtonInfoType.success,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Jumlah porsi')),
                          );
                        },
                      ),
                    ],
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
