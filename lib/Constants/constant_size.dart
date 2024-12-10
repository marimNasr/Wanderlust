import 'package:flutter/cupertino.dart';

class screenSize{
  static late double width;
  static late double height;

  static void init_screenSize(BuildContext context){
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
}