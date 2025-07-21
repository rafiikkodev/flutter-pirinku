import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_pirinku/widgets/button_large_primary.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0; // menyimpan indeks, dimulai dari 0
  CarouselSliderController carouselController =
      CarouselSliderController(); // OOP

  List<String> titles = [
    //
    "Cari Resep Gampang",
    "Masak Jadi Seru",
    "Makan Enak",
  ];

  List<String> subtitles = [
    //
    "Mulai perjalanan sehat Anda sekarang dengan perencanaan makanan yang cerdas dan mudah.",
    "Pilih preferensi makanan favorit Anda agar kami dapat memberikan ide resep yang sesuai.",
    "Kelola anggaran dengan cerdas dan nikmati makanan lezat tanpa khawatir biaya!",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 168),
                CarouselSlider(
                  items: [
                    Image.asset(
                      "assets/onboarding1.png",
                      height: 200,
                    ),
                    Image.asset(
                      "assets/onboarding2.png",
                      height: 232,
                    ),
                    Image.asset(
                      "assets/onboarding3.png",
                      height: 232,
                    ),
                  ],
                  options: CarouselOptions(
                    height: 232,
                    viewportFraction: 1, // mengatur jarak antar gambar
                    enableInfiniteScroll: false, // supaya tidak infinity
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index; //
                      });
                    },
                  ),
                  carouselController: carouselController, //
                ),
                const SizedBox(
                  height: 45,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: txtWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        titles[currentIndex], //
                        style: primaryTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        subtitles[currentIndex],
                        style: secondaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 52),
                      Wrap(
                        spacing: 10,
                        alignment: WrapAlignment.center,
                        children: List.generate(3, (index) {
                          return Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == index
                                  ? txtPrimary
                                  : txtSecondary,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 50),
                      CustomButton(
                        text: currentIndex < 2 ? "Lanjut" : "Mulai",
                        onPressed: () {
                          if (currentIndex < 2) {
                            carouselController.nextPage();
                          } else {
                            Navigator.pushNamed(context, "/register");
                          }
                        },
                        backgroundColor: primaryGreenColor,
                        textColor: txtWhite,
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/register");
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Belum punya akun? ",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium,
                                ),
                              ),
                              TextSpan(
                                text: "Buat akun",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium,
                                  color: primaryGreenColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, "/register");
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 50,
            right: 24,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/register");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: ShapeDecoration(
                  color: const Color(0xFF43B275),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Lewati",
                        style: primaryTextStyle.copyWith(
                          color: txtWhite,
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
