import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<void> register() async {
    try {
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

      print('Starting registration process...'); // Tambahkan log
      print('Email: ${email.value}');
      print('Password: ${password.value.length} characters');

      // Create user with email and password
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.value.trim(),
            password: password.value,
          );

      print(
        'User created successfully: ${userCredential.user?.uid}',
      ); // Tambahkan log

      // Save additional user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username.value,
        'email': email.value,
        'fullName': fullName.value,
        'phoneNumber': phoneNumber.value,
        'address': address.value,
        'coordinates': coordinates.value,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print('User data saved to Firestore'); // Tambahkan log

      Get.snackbar(
        'Sukses',
        'Pendaftaran berhasil',
        backgroundColor: primaryGreenColor,
        colorText: txtWhite,
        snackPosition: SnackPosition.TOP,
      );

      Get.offAllNamed('/cookingtool');
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}'); // Tambahkan log
      String errorMessage = '';

      switch (e.code) {
        case 'weak-password':
          errorMessage = 'Password terlalu lemah';
          break;
        case 'email-already-in-use':
          errorMessage = 'Email sudah terdaftar';
          break;
        case 'invalid-email':
          errorMessage = 'Format email tidak valid';
          break;
        default:
          errorMessage = 'Terjadi kesalahan pada sistem';
          // Log the actual error for debugging but don't show to user
          print('Actual error: ${e.message}');
      }

      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: bgRedColor,
        colorText: txtWhite,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      print('General error: $e'); // Tambahkan log
      Get.snackbar(
        'Error',
        'Terjadi kesalahan yang tidak terduga',
        backgroundColor: bgRedColor,
        colorText: txtWhite,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
