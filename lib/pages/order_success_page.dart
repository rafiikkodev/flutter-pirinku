import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({super.key});

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGreenColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Animated check icon ────────────────────────────────────
              ScaleTransition(
                scale: _scaleAnim,
                child: SvgPicture.asset(
                  'assets/icons/icon_done.svg',
                  width: 205,
                  height: 205,
                  colorFilter: ColorFilter.mode(txtWhite, BlendMode.srcIn),
                ),
              ),

              const SizedBox(height: 32),

              // ── Label ─────────────────────────────────────────────────
              FadeTransition(
                opacity: _fadeAnim,
                child: Text(
                  'Pesanan sudah dibayar',
                  style: TextStyle(
                    color: txtWhite,
                    fontSize: 18,
                    fontFamily: visbyRoundCF,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
