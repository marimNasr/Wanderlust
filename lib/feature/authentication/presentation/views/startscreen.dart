import 'package:flutter/material.dart';
import 'package:wonderlustapp/constant/constants.dart';
import 'package:wonderlustapp/feature/authentication/presentation/views/signIn.dart';
import 'package:wonderlustapp/feature/authentication/presentation/views/signUp.dart';

class Startscreen extends StatefulWidget {
  const Startscreen({super.key});
  static String routename ="Startscreen";

  @override
  State<Startscreen> createState() => _StartscreenState();
}

class _StartscreenState extends State<Startscreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        body:  Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                const Image(image: AssetImage("assets/logo.png")),
            const Text("Welcome To",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                const Text("WanderLust&Start ",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                const Text("Discover the world with our ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
                const Text("travel companion ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
           const SizedBox(height: 93,),
           const Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(Icons.attractions,size: 30,),
               SizedBox(width: 20,),
               Icon(Icons.restaurant,size: 30,),
               SizedBox(width: 20,),
               Icon(Icons.hotel_sharp,size: 30,),
               SizedBox(width: 20,),
               Icon(Icons.airplanemode_active,size: 30,),

           ],),
                const SizedBox(height: 93,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange

                    ),
                     onPressed: (){
                       Navigator.pushReplacementNamed(context, SignUp.routeName);
                     }, child: const Padding(
                       padding:  EdgeInsets.all(8.0),
                       child:  Text("Sign Up",style: TextStyle(fontSize:30,fontWeight: FontWeight.w600,color: Colors.white ),),
                     ),
                   ),
                   const SizedBox(width: 40,),
                   ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       backgroundColor:mainColor,

                     ),
                       onPressed: (){
                        Navigator.pushReplacementNamed(context, SignIn.routeName);
                       }, child: const Padding(
                     padding:  EdgeInsets.all(8.0),
                     child:  Text("Sign In",style: TextStyle(fontSize:30,fontWeight: FontWeight.w600 ,color: Colors.black),),
                   )
                   )],
               )

          ]),
        )
      ),
    );
  }
}
