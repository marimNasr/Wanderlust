import 'package:flutter/material.dart';

import '../../../../constant/constants.dart';


class SecretTextform extends StatefulWidget {
  const SecretTextform(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.fKey,
      required this.controller_parent, required this.textColor});
  final String labelText;
  final TextEditingController controller;
  final GlobalKey<FormState> fKey;
  final TextEditingController? controller_parent;
  final Color textColor;
  @override
  State<SecretTextform> createState() => _SecretTextformState();
}

class _SecretTextformState extends State<SecretTextform> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.fKey,
      child: Padding(
        padding: EdgeInsets.only(
          left: ScreenSize.width/26.2,
          right: ScreenSize.width/26.2,
        ),
        child: TextFormField(
          obscureText: obscureText,
          controller: widget.controller,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: orange),
              borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/25)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: orange, width: ScreenSize.height/290),
              borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/25)),
            ),
            labelText: widget.labelText,
            labelStyle: TextStyle(color: widget.textColor),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: obscureText
                  ?  Icon(Icons.visibility_off, color:darkOlive ,)
                  :  Icon(Icons.visibility, color: darkOlive,),
            ),
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return "please , Enter ${widget.labelText}";
            }
            if (widget.labelText == "Confirm Password" &&
                widget.controller_parent != null) {
              if (val != widget.controller_parent!.text) {
                return "Password does not match";
              }
              return null;
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
