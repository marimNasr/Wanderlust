import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation/Constants/constant_color.dart';
import 'package:graduation/features/Authentication/data/userModel.dart';
import 'package:graduation/features/Home/presentation/widgets/Search_bar.dart';
import 'package:graduation/features/Home/presentation/widgets/content_Grid.dart';
import 'package:video_player/video_player.dart'; // Import video_player package
import '../../../../Constants/constant_size.dart';
import '../widgets/categoryList.dart';

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

    // // Initialize the video controller
    // _controller = VideoPlayerController.asset('assets/traveller.mp4') // Add the video URL here
    //   ..initialize().then((_) {
    //     if (mounted) {
    //       setState(() {}); // Refresh UI after initialization
    //       _controller.play();
    //       _controller.setLooping(true);
    //     } // Automatically play the video
    //   });
  }

  // @override
  // void dispose() {
  //   _controller.dispose(); // Dispose of the controller when done
  //   super.dispose();
  // }

  void updateSelectedTopic(String topic) {
    setState(() {
      selectedTopic = topic;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize.init_screenSize(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        body: Column(
          children: [
            SizedBox(height: screenSize.height / 15),
            Row(
              children: [
                SizedBox(width: screenSize.width / 12),
                userData != null
                     ? Container(
                  width: screenSize.width / 6,
                  height: screenSize.width / 6,
                  decoration: BoxDecoration(
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
                ) : CircularProgressIndicator(),
                SizedBox(width: screenSize.width / 12), // Add spacing
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, ${userData?.name}!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
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
            SizedBox(height: screenSize.height / 25),
            searchBar(),

            SizedBox(height: 20), // Add spacing between sections
            categoryList(
              selectedTopic: selectedTopic,
              onSelected: updateSelectedTopic,
            ),
            content_grid(
              selectedTopic: selectedTopic,
            ),

          ],
        ),
      ),
    );
  }
}
