import 'package:flutter/material.dart';
import 'package:flutter_pirinku/widgets/button_large_primary.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController controller = Get.put(AuthController());

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: controller.email.value);
    passwordController = TextEditingController(text: controller.password.value);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Masuk ke Akunmu',
                        style: primaryTextStyle.copyWith(
                          color: txtPrimary,
                          fontSize: 22,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Lanjut masak enak bareng kami',
                        style: primaryTextStyle.copyWith(
                          color: txtPrimary,
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      label: 'Email',
                      controller: emailController,
                      onChanged: (value) => controller.email.value = value,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 25),
                    _buildPasswordField(
                      label: 'Kata Sandi',
                      controller: passwordController,
                      onChanged: (value) => controller.password.value = value,
                      isPasswordVisible: controller.isPasswordVisible,
                      onToggleVisibility: controller.togglePasswordVisibility,
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () => Get.toNamed('/forgot-password'),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: 'Lupa Kata Sandi?',
                          style: primaryTextStyle.copyWith(
                            color: primaryGreenColor,
                            fontSize: 14,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: 'Masuk',
                      onPressed: () async {
                        // Trim whitespace dan validate inputs
                        String emailText = emailController.text.trim();
                        String passwordText = passwordController.text.trim();

                        // Validasi field kosong
                        if (emailText.isEmpty && passwordText.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Email dan password harus diisi',
                            backgroundColor: bgRedColor,
                            colorText: txtWhite,
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(seconds: 3),
                          );
                          return;
                        } else if (emailText.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Email harus diisi',
                            backgroundColor: bgRedColor,
                            colorText: txtWhite,
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(seconds: 3),
                          );
                          return;
                        } else if (passwordText.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Password harus diisi',
                            backgroundColor: bgRedColor,
                            colorText: txtWhite,
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(seconds: 3),
                          );
                          return;
                        }

                        // Validasi format email
                        if (!GetUtils.isEmail(emailText)) {
                          Get.snackbar(
                            'Error',
                            'Format email tidak valid',
                            backgroundColor: bgRedColor,
                            colorText: txtWhite,
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(seconds: 3),
                          );
                          return;
                        }

                        // Update controller values
                        controller.email.value = emailText;
                        controller.password.value = passwordText;

                        // Attempt login
                        try {
                          await controller.login();

                          // If login successful, clear the form and navigate to beranda
                          if (controller.isLoggedIn) {
                            emailController.clear();
                            passwordController.clear();
                            Get.offAllNamed('/beranda');
                          }
                        } catch (e) {
                          // Error sudah ditangani di controller
                          // Tidak perlu menampilkan snackbar lagi di sini
                          print('Login error handled by controller: $e');
                        }
                      },
                    ),
                    const SizedBox(height: 25),
                    _buildBottomText(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: label,
            style: primaryTextStyle.copyWith(
              color: txtPrimary,
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: primaryGreenColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            style: primaryTextStyle.copyWith(
              color: txtPrimary,
              fontSize: 14,
              fontWeight: medium,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required RxBool isPasswordVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: label,
            style: primaryTextStyle.copyWith(
              color: txtPrimary,
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: primaryGreenColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Obx(
            () => TextField(
              controller: controller,
              onChanged: onChanged,
              obscureText: !isPasswordVisible.value,
              style: primaryTextStyle.copyWith(
                color: txtPrimary,
                fontSize: 14,
                fontWeight: medium,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: txtPrimary,
                  ),
                  onPressed: onToggleVisibility,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomText() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: primaryTextStyle.copyWith(
            color: txtPrimary,
            fontSize: 14,
            fontWeight: medium,
          ),
          children: [
            const TextSpan(text: 'Belum punya akun? '),
            TextSpan(
              text: 'Buat akun',
              style: TextStyle(color: primaryGreenColor, fontWeight: medium),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Get.offNamed('/register'),
            ),
          ],
        ),
      ),
    );
  }
}
