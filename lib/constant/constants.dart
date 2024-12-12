import 'package:flutter/material.dart';

class ScreenSize{
 static late double width;
 static late double height;
 static void init(BuildContext context){
  width=MediaQuery.of(context).size.width;
  height=MediaQuery.of(context).size.height;
 }
}
Color mainColor = const Color.fromARGB(255, 255, 252, 245);//
Color selectedCategory = const Color.fromARGB(255, 255, 249, 234);
Color videoColor = const Color.fromARGB(255,236, 223, 208);
Color buttonsLabel = const Color.fromARGB(255, 255, 252, 243);//
Color orange = const Color.fromARGB(255, 236, 187, 104);//
Color darkOlive = const  Color.fromARGB(255, 85, 76, 42);//
