import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Authentication/presentation/views/signIn.dart';


class homePage extends StatefulWidget {
  const homePage({super.key});
  static String routeName = "homePage";

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 249, 234),
      body: Column(
        children: [
          IconButton(onPressed: (){
            //use firebase auth to sign out
            FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacementNamed(context, SignIn.routeName));
          }, iconSize: 50, icon: Icon(Icons.logout_outlined)),
          Image(image: AssetImage('assets/logo.png')),]
      )
    );
  }
}
