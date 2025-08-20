import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/resources/ColorManager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtils{
  static showLoadingDialog(BuildContext context){
    showDialog(context: context, builder: (context) => AlertDialog(
        alignment: Alignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: CircularProgressIndicator(),)
        ],
      ),
    ),);
  }
  static showMessageDialog(BuildContext context,String message){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: Text(message),

      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("ok".tr()))
      ],
    ),);
  }
  static showToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.blackColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}