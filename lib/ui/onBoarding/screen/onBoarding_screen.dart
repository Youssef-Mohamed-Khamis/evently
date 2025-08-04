import 'package:evently/core/resources/ColorManager.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/StringsManager.dart';
import '../../start/screen/start_screen.dart';
import '../widget/onboard_page.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isLastPage = currentIndex == 2;
    bool isFirstPage = currentIndex == 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset(
          AssetsManager.logoBar,
          height: 50,
          fit: BoxFit.fitHeight,
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
              children: [
                OnboardPage(
                  image: AssetsManager.boardOne,
                  title: StringsManager.boardOneTitle,
                  description: StringsManager.boardOneDesc,
                ),
                OnboardPage(
                  image: AssetsManager.boardTwo,
                  title: StringsManager.boardTwoTitle,
                  description: StringsManager.boardTwoDesc,
                ),
                OnboardPage(
                  image: AssetsManager.boardThree,
                  title: StringsManager.boardThreeTitle,
                  description: StringsManager.boardThreeDesc,
                ),
              ],
            ),
          ),

          SizedBox(height: 48),

          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!isFirstPage)
                  Padding(
                    padding:  EdgeInsets.only(left: 20),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: ColorManager.primaryColor,
                      iconSize: 30,
                      onPressed: () {
                        _controller.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  )
                else
                   SizedBox(width: 48),

                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    activeDotColor: ColorManager.primaryColor,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: Icon(
                        Icons.arrow_forward,
                    ),
                    color: ColorManager.primaryColor,
                    iconSize: 30,
                    onPressed: () {
                      if (isLastPage) {
                        Navigator.pushReplacementNamed(context, StartScreen.routeName);
                      } else {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
