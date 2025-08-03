import 'package:flutter/material.dart';

import '../resources/ColorManager.dart';

class CustomButton extends StatelessWidget {
  String title;
  void Function() onClick;
  CustomButton({required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: ColorManager.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          )
        ),
        child: Text(title,style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500
        ),)
    );
  }
}
