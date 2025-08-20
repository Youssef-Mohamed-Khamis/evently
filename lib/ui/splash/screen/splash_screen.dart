
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/resources/AssetsManager.dart';
import '../../home/screen/home_screen.dart';
import '../../login/screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AssetsManager.logo))
          .animate(
        onComplete: (controller) {
          if(FirebaseAuth.instance.currentUser==null){
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }else{
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
        },
      )
          .fade(duration: Duration(seconds: 2))
          .slideX(duration: Duration(seconds: 2)),
    );
  }
}
