import 'package:evently/core/resources/AssetsManager.dart';
import 'package:evently/core/resources/ColorManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../onBoarding/screen/onBoarding_screen.dart';
import '../../start/screen/start_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightBackgroundColor,
      body: Center(child: Image.asset(AssetsManager.logo))
          .animate(
        onComplete: (controller) {
          Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
        },
      )
          .scale(duration: Duration(seconds: 2))
          .fade(duration: Duration(seconds: 2)),
    );
  }
}
