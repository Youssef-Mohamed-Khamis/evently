import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
}