import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/DialogUtils.dart';
import 'package:evently/ui/login/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../ThemeProvider.dart';
import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/resources/constants.dart';
import '../../../core/reusable_components/CustomButton.dart';
import '../../../core/reusable_components/CustomField.dart';
import '../../../core/reusable_components/CustomSwitch.dart';
import '../../forget_password/screen/forget_password_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int selectedLanguage = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  late TextEditingController nameController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    rePasswordController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    rePasswordController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    if(context.locale.languageCode=="ar"){
      selectedLanguage = 1;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("register".tr()),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AssetsManager.logo),
                  SizedBox(height: 24,),
                  CustomField(
                    keyboard: TextInputType.name,
                    hint: "name".tr(),
                    prefix: AssetsManager.person,
                    controller: nameController,
                    validation: (value) {
                      if(value == null || value.isEmpty){
                        return "shouldEmpty".tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  CustomField(
                    keyboard: TextInputType.emailAddress,
                    controller: emailController,
                    hint: 'email'.tr(),
                    prefix: AssetsManager.email,
                    validation: (value){
                      if(value == null || value.isEmpty){
                        return "shouldEmpty".tr();
                      }
                      if(!RegExp(emailRegex).hasMatch(value)){
                        return "Email not valid";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  CustomField(
                    keyboard: TextInputType.visiblePassword,
                    controller: passwordController,
                    hint: 'password'.tr(),
                    prefix: AssetsManager.lock,
                    isPassword: true,
                    validation: (value) {
                      if(value == null || value.isEmpty){
                        return "shouldEmpty".tr();
                      }
                      if(value.length<8){
                        return "password mustn't be less than 8 char";
                      }

                    },
                  ),
                  SizedBox(height: 16,),
                  CustomField(
                    keyboard: TextInputType.visiblePassword,
                    controller: rePasswordController,
                    hint: "rePass".tr(),
                    prefix: AssetsManager.lock,
                    isPassword: true,
                    validation: (value) {
                      if(value != passwordController.text){
                        return "Must be same";
                      }
                      return null;


                    },
                  ),
                  SizedBox(height: 16,),
                  Container(
                    width: double.infinity,
                    child: CustomButton(title: "register".tr(), onClick: (){
                      if(formKey.currentState!.validate()){
                        createAccount();
                        // create new account
                      }
                    }),
                  ),
                  SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("alreadyHaveAcc".tr(),style: Theme.of(context).textTheme.bodySmall,),
                      TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          child: Text("login".tr(),
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontSize: 16,
                                decorationColor: Theme.of(context).colorScheme.primary,
                                decorationThickness: 2,

                                decoration: TextDecoration.underline
                            ),)),
                    ],
                  ),
                  SizedBox(height: 24,),
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
            ),
          ),
        ),
      ),
    );
  }
  createAccount()async{
    try{
      DialogUtils.showLoadingDialog(context);
      var credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      Navigator.pop(context);
    }on FirebaseAuthException catch(e){
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }catch(e){
      print(e.toString());
    }

  }

}
