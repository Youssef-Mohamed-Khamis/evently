import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/UserProvider.dart';
import '../../../core/resources/ColorManager.dart';
import '../../create_event/screen/CreateEventScreen.dart';
import '../tabs/home_tab/HomeTab.dart';
import '../tabs/love_tab/LoveTab.dart';
import '../tabs/map_tab/MapTab.dart';
import '../tabs/profile_tab/ProfileTab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs=[
    HomeTab(),
    MapTab(),
    LoveTab(),
    ProfileTab()
  ];
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context,listen: false).fetchUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, CreateEventScreen.routeName);
          },
          child: Icon(Icons.add,
            size: 50,
            color: ColorManager.whiteColor,),
          ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
          onTap: (newIndex) {
            setState(() {
              selectedIndex = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
                label: "home".tr(),
                icon: SvgPicture.asset("assets/images/home.svg"),
                activeIcon: SvgPicture.asset("assets/images/home_selected.svg")
            ),
            BottomNavigationBarItem(
                label: "map".tr(),
                icon: SvgPicture.asset("assets/images/map.svg"),
                activeIcon: SvgPicture.asset("assets/images/map_selected.svg")
            ),
            BottomNavigationBarItem(
                label: "love".tr(),
                icon: SvgPicture.asset("assets/images/heart.svg"),
                activeIcon: SvgPicture.asset("assets/images/heart_selected.svg")
            ),
            BottomNavigationBarItem(
                label: "profile".tr(),
                icon: SvgPicture.asset("assets/images/user.svg"),
                activeIcon: SvgPicture.asset("assets/images/user_selected.svg")
            ),
          ]
      ),
      body: tabs[selectedIndex],
    );
  }
}
