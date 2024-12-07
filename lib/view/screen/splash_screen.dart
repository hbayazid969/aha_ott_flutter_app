import 'package:aha_ott_flutter_app/controller/splash_controller.dart';
import 'package:aha_ott_flutter_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (splashController) {
        return Scaffold(
          backgroundColor: AppColors.appBgColor,
          body: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/splash_bg.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Top-center Logo
              Positioned(
                top: MediaQuery.of(context).size.height * 0.40,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/splash_logo.png',
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
