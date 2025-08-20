import 'package:flutter/material.dart';

class EventType extends StatelessWidget {
  String imagePath;
  EventType(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          height: 203,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
