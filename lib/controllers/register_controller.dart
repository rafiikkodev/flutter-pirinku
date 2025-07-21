import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final currentStep = 0.obs;

  // Step 1 data
  final username = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;

  // Step 2 data
  final fullName = ''.obs;
  final phoneNumber = ''.obs;
  final address = ''.obs;
  final coordinates = ''.obs;

  void nextStep() {
    if (currentStep.value == 0) {
      // Validasi step 1
      if (username.value.isEmpty ||
          email.value.isEmpty ||
          password.value.isEmpty ||
          confirmPassword.value.isEmpty) {
        Get.snackbar(
          'Error',
          'Semua form harus diisi',
          backgroundColor: bgRedColor,
          colorText: txtWhite,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
      if (password.value != confirmPassword.value) {
        Get.snackbar(
          'Error',
          'Kata sandi tidak cocok',
          backgroundColor: bgRedColor,
          colorText: txtWhite,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
    }
    currentStep.value++;
  }

  void register() {
    // Validate step 2
    if (fullName.value.isEmpty ||
        phoneNumber.value.isEmpty ||
        address.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua form harus diisi',
        backgroundColor: bgRedColor,
        colorText: txtWhite,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    Get.offAllNamed('/home');
  }
}
