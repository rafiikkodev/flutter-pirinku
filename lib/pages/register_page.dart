import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/widgets/button_large_primary.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_pirinku/controllers/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController controller = Get.put(RegisterController());

  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: controller.username.value);
    emailController = TextEditingController(text: controller.email.value);
    passwordController = TextEditingController(text: controller.password.value);
    confirmPasswordController = TextEditingController(
      text: controller.confirmPassword.value,
    );
    fullNameController = TextEditingController(text: controller.fullName.value);
    phoneNumberController = TextEditingController(
      text: controller.phoneNumber.value,
    );
    addressController = TextEditingController(text: controller.address.value);
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
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
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.currentStep.value == 0
                            ? 'Buat Akun'
                            : 'Detail Diri',
                        style: primaryTextStyle.copyWith(
                          color: txtPrimary,
                          fontSize: 22,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.currentStep.value == 0
                            ? 'Gabung dan mulai masak bareng pirinku'
                            : 'Isi detail diri kamu',
                        style: primaryTextStyle.copyWith(
                          color: txtPrimary,
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Obx(
                  () => controller.currentStep.value == 0
                      ? _buildStep1()
                      : _buildStep2(),
                ),
                const SizedBox(height: 25),
                _buildBottomText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      children: [
        _buildTextField(
          label: 'Username',
          controller: usernameController,
          onChanged: (value) => controller.username.value = value,
        ),
        const SizedBox(height: 25),
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
          isPasswordVisible: isPasswordVisible,
        ),
        const SizedBox(height: 25),
        _buildPasswordField(
          label: 'Konfirmasi Kata Sandi',
          controller: confirmPasswordController,
          onChanged: (value) => controller.confirmPassword.value = value,
          isPasswordVisible: isConfirmPasswordVisible,
        ),
        const SizedBox(height: 25),
        CustomButton(
          text: controller.currentStep.value == 0 ? 'Lanjut' : 'Daftar',
          onPressed: () async {
            if (controller.currentStep.value == 0) {
              controller.nextStep();
            } else {
              try {
                await controller.register();
              } catch (e) {
                print('Error in register page: $e');
              }
            }
          },
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      children: [
        _buildTextField(
          label: 'Nama Lengkap',
          controller: fullNameController,
          onChanged: (value) => controller.fullName.value = value,
        ),
        const SizedBox(height: 25),
        _buildTextField(
          label: 'No Hp',
          controller: phoneNumberController,
          onChanged: (value) => controller.phoneNumber.value = value,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 25),
        _buildTextField(
          label: 'Alamat Lengkap',
          controller: addressController,
          onChanged: (value) => controller.address.value = value,
          maxLines: 3,
        ),
        const SizedBox(height: 25),
        CustomButton(
          text: 'Daftar',
          onPressed: () async {
            try {
              await controller.register();
            } catch (e) {
              print('Error in register page: $e');
            }
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: primaryTextStyle.copyWith(
            color: txtPrimary,
            fontSize: 14,
            fontWeight: medium,
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
            maxLines: maxLines,
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: primaryTextStyle.copyWith(
            color: txtPrimary,
            fontSize: 14,
            fontWeight: medium,
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
                  onPressed: () =>
                      isPasswordVisible.value = !isPasswordVisible.value,
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
            const TextSpan(text: 'Sudah punya akun? '),
            TextSpan(
              text: 'Masuk',
              style: primaryTextStyle.copyWith(
                color: primaryGreenColor,
                fontSize: 14,
                fontWeight: medium,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Get.offNamed('/login'),
            ),
          ],
        ),
      ),
    );
  }
}
