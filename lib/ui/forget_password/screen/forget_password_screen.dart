import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/resources/constants.dart';
import '../../../core/reusable_components/CustomButton.dart';
import '../../../core/reusable_components/CustomField.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = "forgetPsss";
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("forgetPass".tr()),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key:formKey ,
          child: Column(
            children: [
              Image.asset(AssetsManager.forgetPass),
              SizedBox(height: 24,),
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

              SizedBox(height: 24,),
              Container(
                width: double.infinity  ,
                child: CustomButton(title: "restPass".tr(), onClick: (){
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

}
