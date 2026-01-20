import 'package:flutter/material.dart';
import 'package:flutter_pirinku/widgets/custom_alert.dart';

// Contoh penggunaan CustomAlert
class CustomAlertExample extends StatefulWidget {
  const CustomAlertExample({Key? key}) : super(key: key);

  @override
  State<CustomAlertExample> createState() => _CustomAlertExampleState();
}

class _CustomAlertExampleState extends State<CustomAlertExample> {
  bool showErrorAlert = true;
  bool showWarningAlert = true;
  bool showSuccessAlert = true;
  bool showInfoAlert = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Alert Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Error Alert
            if (showErrorAlert) ...[
              const Text(
                'Error Alert',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              CustomAlert(
                message:
                    'Setiap pembelian barang akan di masukan ke laporan dana bulanan',
                type: AlertType.error,
                isDismissible: true,
                onDismiss: () {
                  setState(() {
                    showErrorAlert = false;
                  });
                },
              ),
              const SizedBox(height: 24),
            ],

            // Warning Alert
            if (showWarningAlert) ...[
              const Text(
                'Warning Alert',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              CustomAlert(
                message: 'Peringatan: Stok bahan makanan hampir habis!',
                type: AlertType.warning,
                isDismissible: true,
                onDismiss: () {
                  setState(() {
                    showWarningAlert = false;
                  });
                },
              ),
              const SizedBox(height: 24),
            ],

            // Success Alert
            if (showSuccessAlert) ...[
              const Text(
                'Success Alert',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              CustomAlert(
                message: 'Berhasil! Resep telah ditambahkan ke daftar favorit',
                type: AlertType.success,
                isDismissible: true,
                onDismiss: () {
                  setState(() {
                    showSuccessAlert = false;
                  });
                },
              ),
              const SizedBox(height: 24),
            ],

            // Info Alert
            if (showInfoAlert) ...[
              const Text(
                'Info Alert',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              CustomAlert(
                message: 'Info: Jangan lupa cek jadwal masak minggu ini',
                type: AlertType.info,
                isDismissible: true,
                onDismiss: () {
                  setState(() {
                    showInfoAlert = false;
                  });
                },
              ),
              const SizedBox(height: 24),
            ],

            // Alert tanpa dismiss button
            const Text(
              'Alert Without Dismiss',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const CustomAlert(
              message: 'Alert ini tidak bisa ditutup',
              type: AlertType.info,
              isDismissible: false,
            ),
            const SizedBox(height: 24),

            // Reset button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showErrorAlert = true;
                  showWarningAlert = true;
                  showSuccessAlert = true;
                  showInfoAlert = true;
                });
              },
              child: const Text('Reset All Alerts'),
            ),
          ],
        ),
      ),
    );
  }
}
