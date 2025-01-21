import 'package:flutter/material.dart';

import '../../../Constants/constant_color.dart';
import '../../authentication/presentation/views/startscreen.dart';


class Splachscreen extends StatefulWidget {
  const Splachscreen({super.key});
  static String routename ="Splachscreen";

  @override
  State<Splachscreen> createState() => _SplachscreenState();
}

class _SplachscreenState extends State<Splachscreen> {
  void initstate(){
    super.initState();
    Future.delayed(const Duration(seconds: 5),(){
      Navigator.pushReplacementNamed(context, Startscreen.routename);
    });
  }
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: mainColor,

  body:  Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
       const Image(image: AssetImage("assets/logo.png")),
      CircularProgressIndicator(color:orange,)
    ],
  )),
    );
  }
}
