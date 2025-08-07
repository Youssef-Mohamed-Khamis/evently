import 'package:easy_localization/easy_localization.dart';
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

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset(
          AssetsManager.logoBar,
          height: 50,
          fit: BoxFit.fitHeight,
        ),
        iconTheme: IconThemeData(color: theme.iconTheme.color),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 50),
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
              children: [
                OnboardPage(
                  image: AssetsManager.boardOne,
                  title: 'boardOneTitle'.tr(),
                  description: 'boardOneDesc'.tr(),
                ),
                OnboardPage(
                  image: AssetsManager.boardTwo,
                  title: 'boardTwoTitle'.tr(),
                  description: 'boardTwoDesc'.tr(),
                ),
                OnboardPage(
                  image: AssetsManager.boardThree,
                  title: 'boardThreeTitle'.tr(),
                  description: 'boardThreeDesc'.tr(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 48),

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
                    padding: const EdgeInsets.only(left: 20),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: theme.primaryColor,
                      iconSize: 30,
                      onPressed: () {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  )
                else
                  const SizedBox(width: 48),

                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    activeDotColor: theme.primaryColor,
                    dotColor: isDark ? Colors.grey : Colors.black26,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    color: theme.primaryColor,
                    iconSize: 30,
                    onPressed: () {
                      if (isLastPage) {
                        Navigator.pushNamed(
                            context, StartScreen.routeName);
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
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
