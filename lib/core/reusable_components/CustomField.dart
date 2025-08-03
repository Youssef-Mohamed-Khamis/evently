import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomField extends StatefulWidget {
  String hint;
  String prefix;
  TextEditingController controller;
  bool isPassword;
  String? Function(String?) validation;
  TextInputType keyboard;
  CustomField({required this.keyboard,required this.hint,required this.prefix,required this.controller,this.isPassword = false,required this.validation});

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    // validation
    return TextFormField(
      keyboardType: widget.keyboard,
      validator:widget.validation ,
      controller:widget.controller,
      style: Theme.of(context).textTheme.titleMedium,
      obscureText: widget.isPassword
          ?isHidden
          :false,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.titleMedium,
        suffixIcon:widget.isPassword
            ?IconButton(
            onPressed: (){
              setState(() {
                isHidden = !isHidden;
              });
            }, icon: Icon(
          isHidden
              ?Icons.visibility_off
              :Icons.visibility,
          color: Theme.of(context).textTheme.titleMedium!.color!,
        )) : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline
            )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline
            )
        ),
        hintText: widget.hint,
        prefixIconConstraints: BoxConstraints(
          maxWidth: 60,
          maxHeight: 60,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16
          ),
          child: SvgPicture.asset(widget.prefix,
            height: 36,
            width: 36,
            colorFilter: ColorFilter.mode(
              Theme.of(context).textTheme.titleMedium!.color!, BlendMode.srcIn
          ),),
        )
      ),
    );
  }
}
