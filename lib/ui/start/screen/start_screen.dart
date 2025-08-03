import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/core/resources/ColorManager.dart';
import 'package:evently/core/resources/StringsManager.dart';
import 'package:evently/core/reusable_components/CustomButton.dart';
import 'package:evently/core/reusable_components/CustomSwitch.dart';
import 'package:flutter/material.dart';
import 'package:evently/core/resources/AssetsManager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartScreen extends StatefulWidget {
  static const String routeName = 'start';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int selectedLanguage = 1;

  int selectedTheme = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          AssetsManager.logoBar,
          height: 50,
          fit: BoxFit.fitHeight,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(child: Image.asset(AssetsManager.startLight, fit: BoxFit.fitHeight)),
            ),
            SizedBox(height: 28),
            Text(
              StringsManager.startTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: ColorManager.primaryColor,
              ),
            ),
            SizedBox(height: 28),
            Text(
              StringsManager.startDesc,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ColorManager.blackColor,
              ),
            ),
            SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringsManager.language,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.primaryColor,
                  ),
                ),
                CustomSwitch(
                  icons: [
                    SvgPicture.asset(AssetsManager.us, width: 35, height: 35),
                    SvgPicture.asset(AssetsManager.eg, width: 35, height: 35),
                  ],
                  current: selectedLanguage,
                  onChange: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringsManager.theme,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.primaryColor,
                  ),
                ),
                CustomSwitch(
                  icons: [
                    SvgPicture.asset(AssetsManager.sun, width: 35, height: 35),
                    SvgPicture.asset(AssetsManager.moon, width: 35, height: 35),
                  ],
                  current: selectedTheme,
                  onChange: (value) {
                    setState(() {
                      selectedTheme = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 28),
            Container(
              width: double.infinity,
              child: CustomButton(
                title: StringsManager.letsStart,
                onClick: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
