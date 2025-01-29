import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app_cating/const/constain_image.dart';
import 'package:app_cating/Token/toekn.dart'; // Your token management class
import 'package:app_cating/view/main_Screen/main_Screen.dart';
import 'package:app_cating/view/onBoarding_Screen/onBoarding_Screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Widget> determineNextScreen() async {
    // Check if a token exists
    String? token = await Toekn.getToken();

    if (token != null && token.isNotEmpty) {
      // Token exists, navigate to MainScreen
      return const MainScreen();
    } else {
      // Token doesn't exist, navigate to OnboardingScreen
      return const OnboardingScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 250,
      splash: SizedBox(
        height: 200,
        child: Image.asset(
          ConstainImage.imageSplash_Screen,
          fit: BoxFit.cover, // Ensure the image scales proportionally
        ),
      ),
      nextScreen: FutureBuilder<Widget>(
        future: determineNextScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              // Fallback to OnboardingScreen if something goes wrong
              return const OnboardingScreen();
            }
          } else {
            // While loading, show a blank container or loader
            return const SizedBox();
          }
        },
      ),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
    );
  }
}
