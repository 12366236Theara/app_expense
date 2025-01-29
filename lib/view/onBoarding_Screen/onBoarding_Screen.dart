import 'package:app_cating/view/signUP_Screen/signUp_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_cating/widget/buttom_custem.dart';
import 'package:app_cating/const/constain_image.dart';
import 'package:app_cating/view/login_screen/login_Screen.dart';

import 'package:app_cating/view/onBoarding_Screen/widget.dart/line.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ConstainImage.imageonboarding_bagra_Screen,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ConstainImage.imageOnbosrlding),
                // Title
                Text(
                  "Take Control of Your Expenses",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 11),
                // Subtitle
                Text(
                  "Track, analyze, and manage your finances in one place.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                // Login Button
                buttomCustem(
                  Colors.deepPurple,
                  "Get Started",
                  () {
                    Get.to(() => LoginScreen());
                  },
                  textColor: Colors.white,
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                const SizedBox(height: 30),

                // Divider
                lines(Colors.white),
                const SizedBox(height: 30),
                buttomCustem(
                  textColor: Colors.white,
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  Colors.grey.shade800,
                  "Create Account",
                  () {
                    Get.to(() => SignUpScreen());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
