import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/UserProvider.dart';
import '../../../../core/resources/ColorManager.dart';
import '../../../../core/resources/StringsManager.dart';
import '../../../login/screen/login_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String selectedLanguage = "en";
  @override
  Widget build(BuildContext context) {
  selectedLanguage = context.locale.languageCode;
  UserProvider provider = Provider.of<UserProvider>(context);
  return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Container(
            padding:EdgeInsets.only(
              top: 50,
              bottom: 16,
              left: 16,
              right: 16
            ),

            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(24)
              )
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(60),
                          bottomEnd: Radius.circular(60),
                        topEnd: Radius.circular(60)
                      )
                  ),
                  child: Icon(
                    Icons.person,
                    color: ColorManager.greyColor,
                    size: 70,
                  ),
                ),
                SizedBox(width: 16,),
                Expanded(
                  child: provider.user==null
                      ?const Center(child: CircularProgressIndicator(),)
                      :Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(provider.user!.name!,style: Theme.of(context).textTheme.headlineMedium,),
                      Text(provider.user!.email!,style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(StringsManager.language.tr(),style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),),
                  SizedBox(height: 16,),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary
                      )
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedLanguage,
                        isExpanded: true,
                          borderRadius: BorderRadius.circular(16),
                          hint: Text("Select the language"),
                          items: [
                            DropdownMenuItem(
                                value: "en",
                                child: Text("English")),
                            DropdownMenuItem(
                                value: "ar",
                                child: Text("العربية")),
                          ],
                          onChanged: (value){
                            setState(() {
                              selectedLanguage = value!;
                              context.setLocale(Locale(selectedLanguage));
                            });

                          }),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffFF5659),
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        )
                      ),
                      onPressed: (){
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                      },
                      child:Row(
                        children: [
                          Icon(Icons.logout,size: 24,color:ColorManager.whiteColor ,),
                          SizedBox(width: 8,),
                          Text("logout".tr(),style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 20
                          ),)
                        ],
                      ))
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
