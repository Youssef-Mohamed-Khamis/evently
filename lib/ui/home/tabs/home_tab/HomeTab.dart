import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/home/tabs/home_tab/tab_views/AllTabView.dart';
import 'package:evently/ui/home/tabs/home_tab/tab_views/BirthdayView.dart';
import 'package:evently/ui/home/tabs/home_tab/tab_views/BookView.dart';
import 'package:evently/ui/home/tabs/home_tab/tab_views/SportView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/UserProvider.dart';

class HomeTab extends StatefulWidget {

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin{
  late TabController tabController ;
  int selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      if(tabController.index!=selectedIndex){
        setState(() {
          selectedIndex = tabController.index;
        });
      }

    });

  }
  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
            bottom: 16,
            top: 40
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(24),
              bottomStart: Radius.circular(24),
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("welcome".tr(),style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14
              ),),
              provider.user==null
                  ?const Center(child: CircularProgressIndicator(),)
                  :Text(provider.user!.name!,style: Theme.of(context).textTheme.headlineMedium,),
              Row(
                children: [
                  SvgPicture.asset("assets/images/map.svg",height: 24,width: 24,),
                  SizedBox(width: 5,),
                  Text("Cairo , Egypt",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ))
                ],
              ),
              TabBar(
                controller: tabController,
                isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: Colors.red,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.white,
                  dividerHeight: 0,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(46),
                      border: Border.all(color: Colors.white),
                      color: Colors.white
                  ),
                  tabs: [
                    Tab(
                      height: 50,
                      child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12
                      ),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(46),
                        border: Border.all(color: Colors.white)
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/Compass.svg",height: 24,width: 24,
                            colorFilter: ColorFilter.mode(selectedIndex==0
                                ?Theme.of(context).colorScheme.primary
                                :Colors.white, BlendMode.srcIn),
                          ),
                          SizedBox(width: 3,),
                          Text("All")
                        ],
                      ),
                    ),),
                    Tab(
                      height: 50,

                      child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12
                      ),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(46),
                          border: Border.all(color: Colors.white)
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/bike.svg",height: 24,width: 24,
                            colorFilter: ColorFilter.mode(selectedIndex==1
                                ?Theme.of(context).colorScheme.primary
                                :Colors.white, BlendMode.srcIn),
                          ),
                          SizedBox(width: 3,),
                          Text("Sport")
                        ],
                      ),
                    ),),
                    Tab(
                      height: 50,
                      child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12
                      ),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(46),
                          border: Border.all(color: Colors.white)
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/cake.svg",height: 24,width: 24,
                            colorFilter: ColorFilter.mode(selectedIndex==2
                                ?Theme.of(context).colorScheme.primary
                                :Colors.white, BlendMode.srcIn),
                          ),
                          SizedBox(width: 3,),
                          Text("Birthday")
                        ],
                      ),
                    ),),
                    Tab(
                      height: 50,
                      child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12
                      ),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(46),
                          border: Border.all(color: Colors.white)
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/book-open.svg",height: 24,width: 24,
                            colorFilter: ColorFilter.mode(selectedIndex==3
                                ?Theme.of(context).colorScheme.primary
                                :Colors.white, BlendMode.srcIn),
                          ),
                          SizedBox(width: 3,),
                          Text("Book Club")
                        ],
                      ),
                    ),),
                  ]
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TabBarView(
              controller: tabController,
                children: [
                  AllTabView(),
                  SportView(),
                  BirthdayView(),
                  BookView(),

                ]
            ),
          ),
        )
      ],
    );
  }
}
