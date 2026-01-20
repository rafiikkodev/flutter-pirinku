import 'package:flutter/material.dart';
import 'package:flutter_pirinku/pages/cooking_tool_page.dart';
import 'package:flutter_pirinku/pages/beranda_page.dart';
import 'package:flutter_pirinku/pages/splash_page.dart';
import 'package:flutter_pirinku/pages/onboarding_page.dart';
import 'package:flutter_pirinku/pages/register_page.dart';
import 'package:flutter_pirinku/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pirinku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF43B275)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashPage()),
        GetPage(name: '/onboarding', page: () => const OnboardingPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/cookingtool', page: () => const CookingToolPage()),
        GetPage(name: '/beranda', page: () => const BerandaPage()),
      ],
    );
  }
}
