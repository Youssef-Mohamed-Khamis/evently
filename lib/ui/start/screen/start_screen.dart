import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../ThemeProvider.dart';
import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/ColorManager.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/resources/constants.dart';
import '../../../core/reusable_components/CustomButton.dart';
import '../../../core/reusable_components/CustomSwitch.dart';
import '../../login/screen/login_screen.dart';

class StartScreen extends StatefulWidget {
  static const String routeName = "start";

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int selectedLanguage = 0;

  int selectedTheme = 0;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    if(themeProvider.themeMode==ThemeMode.dark){
      selectedTheme=1;
    }
    if(context.locale.languageCode=="ar"){
      selectedLanguage = 1;
    }
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManager.logoBar,height: 50,fit: BoxFit.fitHeight,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Expanded(child: Center(child: Image.asset(
                themeProvider.themeMode==ThemeMode.dark
                    ?AssetsManager.startDark
                    :AssetsManager.startLight,fit: BoxFit.fitHeight,))),
              SizedBox(height: 28,),
              Text(StringsManager.startTitle.tr(),style: TextStyle(
                fontWeight: FontWeight.w700,
                color: ColorManager.primaryColor,
                fontSize: 20
              ),),
              SizedBox(height: 28,),
              Text(StringsManager.startDesc.tr(),style: Theme.of(context).textTheme.bodySmall,),
              SizedBox(height: 28,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringsManager.language.tr(),style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500
                  ),),
                  CustomSwitch(
                      onChange: (value){
                        setState(() {
                          selectedLanguage = value;
                        });
                        if(selectedLanguage==1){
                          context.setLocale(Locale("ar"));
                        }else{
                          context.setLocale(Locale("en"));

                        }
                      },
                      icons:[
                        SvgPicture.asset(AssetsManager.us,
                          height: 30,
                          width: 30,
                        ),
                        SvgPicture.asset(AssetsManager.eg, height: 30,
                          width: 30,),
                      ] ,
                      current: selectedLanguage)
                ],
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(StringsManager.theme.tr(),style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500
                ),),
                CustomSwitch(
                    onChange: (value){
                      setState(() {
                        selectedTheme = value;
                        if(selectedTheme==1){
                          themeProvider.changeTheme(ThemeMode.dark);
                        }else{
                          themeProvider.changeTheme(ThemeMode.light);

                        }
                      });
                    },
                    icons:[
                      SvgPicture.asset(AssetsManager.sun,
                        height: 30,
                        width: 30,
                        colorFilter: ColorFilter.mode(selectedTheme==0
                            ?Theme.of(context).colorScheme.onPrimary
                            :ColorManager.primaryColor, BlendMode.srcIn),
                      ),
                      SvgPicture.asset(AssetsManager.moon, height: 30,
                        width: 30,
                        colorFilter: ColorFilter.mode(selectedTheme==1
                            ?Theme.of(context).colorScheme.onPrimary
                            :ColorManager.primaryColor, BlendMode.srcIn),
                      ),
                    ] ,
                    current: selectedTheme)
              ],
            ),
              SizedBox(height: 28,),

            Container(
                width: double.infinity,
                child: CustomButton(
                  title:StringsManager.letsStart.tr(),
                   onClick: (){
                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                   }
                ),
              ),
          ],
        ),
      ),
    );
  }
}
