import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;

  // Login data
  final email = ''.obs;
  final password = ''.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Email dan password harus diisi',
        backgroundColor: bgRedColor,
        colorText: txtWhite,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // TODO: Implement login logic
    _isLoggedIn.value = true;
    Get.offAllNamed('/home');
  }

  void logout() {
    _isLoggedIn.value = false;
  }
}
