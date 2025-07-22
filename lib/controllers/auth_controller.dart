import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;

  // Login data
  final email = ''.obs;
  final password = ''.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    try {
      // Basic validation
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

      // Attempt to sign in
      await _auth.signInWithEmailAndPassword(
        email: email.value.trim(),
        password: password.value,
      );

      // If successful
      _isLoggedIn.value = true;
      Get.snackbar(
        'Sukses',
        'Login berhasil',
        backgroundColor: primaryGreenColor,
        colorText: txtWhite,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );

      // Add slight delay before navigation
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed('/homepage');
    } on FirebaseAuthException catch (e) {
      _isLoggedIn.value = false;
      String errorMessage = '';

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Email tidak terdaftar';
          break;
        case 'wrong-password':
          errorMessage = 'Password salah';
          break;
        case 'invalid-email':
          errorMessage = 'Format email tidak valid';
          break;
        case 'user-disabled':
          errorMessage = 'Akun telah dinonaktifkan';
          break;
        default:
          errorMessage = 'Terjadi kesalahan: ${e.message}';
      }

      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: bgRedColor,
        colorText: txtWhite,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      throw e; // Re-throw to handle in the UI
    } catch (e) {
      _isLoggedIn.value = false;
      Get.snackbar(
        'Error',
        'Terjadi kesalahan yang tidak terduga',
        backgroundColor: bgRedColor,
        colorText: txtWhite,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      throw e; // Re-throw to handle in the UI
    }
  }

  void logout() async {
    try {
      await _auth.signOut();
      _isLoggedIn.value = false;
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal logout',
        backgroundColor: bgRedColor,
        colorText: txtWhite,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
