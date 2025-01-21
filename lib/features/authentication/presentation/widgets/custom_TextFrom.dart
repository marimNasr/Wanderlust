import 'package:flutter/material.dart';

import '../../../../Constants/constant_color.dart';
import '../../../../Constants/constant_size.dart';


class CustomTextfrom extends StatelessWidget {
  const CustomTextfrom(
      {super.key,
        required this.labelText,
        required this.controller,
        required this.fKey, required this.textColor});

  final String labelText;
  final TextEditingController controller;
  final GlobalKey<FormState> fKey;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: fKey,
      child: Padding(
        padding: EdgeInsets.only(
          left: screenSize.width/26.2,
          right: screenSize.width/26.2,
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: textColor),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: orange),
              borderRadius: BorderRadius.all(Radius.circular(screenSize.width/25)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: orange, width: screenSize.height/290),
              borderRadius: BorderRadius.all(Radius.circular(screenSize.width/25)),
            ),
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return "Please enter $labelText";
            }
            return null;
          },
        ),
      ),
    );
  }
}
