import 'package:flutter/material.dart';
import 'package:wonderlustapp/constant/constants.dart';
import 'package:wonderlustapp/feature/home/presentation/widgets/Search_bar.dart';

class Updatescreen extends StatefulWidget {
  const Updatescreen({super.key});
  static String routename ="Updatescreen";

  @override
  State<Updatescreen> createState() => _UpdatescreenState();
}

class _UpdatescreenState extends State<Updatescreen> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return  Scaffold(
      backgroundColor: orange,
      body: Container(
        height: ScreenSize.height,
        width: ScreenSize.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(130)),
          color: mainColor,

        ),
        child: Column(children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Text("Profile",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
            Image(image: AssetImage("assets/3d-vector-travel-journey-boat-260nw-2314570715-Photoroom.png"))
          ],
          
          ),
          SizedBox(height: ScreenSize.height/5,),
          const searchBar(),
          SizedBox(height: ScreenSize.height/20,),
          const searchBar(),
          SizedBox(height: ScreenSize.height/20,),
          const searchBar(),
          SizedBox(height: ScreenSize.height/5,),

           const Row(
             children: [
               Text("Favourite List",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w600),),
             ],
           ),
          

        ],),
      ),
    );
  }
}
