import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wonderlustapp/Core/models/modelsinterface.dart';
import 'package:wonderlustapp/feature/authentication/presentation/views/updatescreen.dart';
import '../../../../constant/constants.dart';
import '../../../authentication/data/usermodel.dart';
import '../widgets/Search_bar.dart';
import '../widgets/categoryList.dart';
import '../widgets/content_Grid.dart';

class homePage extends StatefulWidget {
   const homePage({super.key});
  static String routeName = "homePage";
  
  
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String selectedTopic = "All";
  userModel? userData;

  
  //late VideoPlayerController _controller; // Video controller

  Future<void> fetchUserData() async {
    try {
      final email = FirebaseAuth.instance.currentUser!.email;
      if (email != null) {
        final fetchedUser = await userModel.getUserByEmail(email);
        log("Fetched User: $fetchedUser");
        setState(() {
          userData = fetchedUser;
        });
      }
    } catch (e) {
      log("Error fetching user data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    
}

  void updateSelectedTopic(String topic) {
    setState(() {
      selectedTopic = topic;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    
    ScreenSize.init(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    Future<void> initialize() async {
  final categoryModel = await args?['categoryModel'];
  final String channelId = args?['channelId'] ?? "";

  print("Category Model: $categoryModel");
  print("Channel ID: $channelId");
}
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        drawer: Drawer(
          child: ListView(
          padding: EdgeInsets.zero,
          children:  [
            ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile",style: TextStyle(fontSize: 30,color: Colors.black),),
            onTap: (){
              Navigator.pushReplacementNamed(context, Updatescreen.routename);
            },
           ),
            ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Log Out",style: TextStyle(fontSize: 30,color: Colors.black),),
            onTap: (){},
           )
          ]
        )),
        body: Column(
          children: [
            SizedBox(height: ScreenSize.height / 15),
            Row(
              children: [
                SizedBox(width: ScreenSize.width / 12),
                userData != null
                     ? Container(
                  width: ScreenSize.width / 6,
                  height: ScreenSize.width / 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Transform.scale(
                    scale: 1.7, // Increase the scale factor for a larger GIF
                    child: ClipOval(
                      child: Image.asset(
                        "assets/traveller.gif",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ) : const CircularProgressIndicator(),
                SizedBox(width: ScreenSize.width / 12), // Add spacing
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, ${userData?.name}!",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      "Where do you want to go?",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: ScreenSize.height / 25),
            const searchBar(),

            const SizedBox(height: 20), // Add spacing between sections
            categoryList(
              selectedTopic: selectedTopic,
              onSelected: updateSelectedTopic,
            ),
            content_grid(
              selectedTopic: selectedTopic, datalist: [] ,
            ),

          ],
        ),
      ),
    );
  }
}
