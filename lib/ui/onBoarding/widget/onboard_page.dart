import 'package:evently/core/resources/ColorManager.dart';
import 'package:flutter/material.dart';

class OnboardPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

   OnboardPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Image.asset(
                image,
                fit: BoxFit.fitHeight,
                height: 350,
              ),
            ),
          ),

           SizedBox(height: 39),

          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20,
              color: ColorManager.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),

           SizedBox(height: 20),

          Expanded(
            flex: 2,
            child: Text(
              description,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                color: ColorManager.blackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
