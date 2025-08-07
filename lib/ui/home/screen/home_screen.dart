import 'package:flutter/material.dart';

import '../../login/screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }, icon: Icon(
              Icons.logout
          ))
        ],
      ),
    );
  }
}
