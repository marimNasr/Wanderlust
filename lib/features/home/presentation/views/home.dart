import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Constants/constant_color.dart';
import '../../../../Constants/constant_size.dart';
import '../../../../Core/models/modelsinterface.dart';
import '../../../authentication/data/usermodel.dart';
import '../../../profile/fav_cubit.dart';
import '../../../profile/views/updatescreen.dart';
import '../cubit/home_cubit.dart';
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
  String selectedTopic = "Popular Places";
  userModel? userData;
  late Modelsresponseinterface categoryModel;
  List<Modelsinterface> dataList = []; // Initialize as an empty list

  // Method to fetch user data
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

  // Method to fetch initial data (Attractions)
  Future<void> fetchInitialData() async {
    try {
      dataList = await HomeCubit().getAttractions();
      setState(() {}); // Rebuild the UI once data is fetched
    } catch (e) {
      log("Error fetching initial data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchInitialData(); // Fetch initial attractions data
  }

  void updateSelectedTopic(String topic) async {
    setState(() {
      selectedTopic = topic;
    });

    // Get the appropriate data based on the selected topic
    switch (selectedTopic) {
      case "Popular Places":
        dataList = await HomeCubit().getAttractions();
        break;
      case "Restaurants":
        dataList = await HomeCubit().getRestaurants();
        break;
      case "Hotels":
        dataList = await HomeCubit().getHotels();
        break;
      case "Airports":
        dataList = await HomeCubit().getAirports();
        break;
      default:
        dataList = [];
    }

    setState(() {
      // Rebuild the UI with the new data
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize.init_screenSize(context);
    log("Data List: ${dataList.isNotEmpty ? dataList[0].rating : 'No data available'}");

    return SafeArea(
      child:Scaffold(
        backgroundColor: mainColor,
          drawer: Drawer(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person, size: 30), // Adjusted icon size
                        title: const Text(
                          "Profile",
                          style: TextStyle(fontSize: 24, color: Colors.black), // Adjusted font size
                        ),
                        onTap: () {
                          context.read<FavCubit>().fetchFavourites();
                          Navigator.pushReplacementNamed(context, Updatescreen.routename);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout, size: 30), // Adjusted icon size
                        title: const Text(
                          "Log Out",
                          style: TextStyle(fontSize: 24, color: Colors.black), // Adjusted font size
                        ),
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

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
                )
                    : const CircularProgressIndicator(),
                SizedBox(width: screenSize.width / 12), // Add spacing
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
            SizedBox(height: screenSize.height / 25),
            const searchBar(),
            const SizedBox(height: 20), // Add spacing between sections
            categoryList(
              selectedTopic: selectedTopic,
              onSelected: updateSelectedTopic,
            ),
            // Display data in content grid after categoryModel is updated
            ContentGrid(
              selectedTopic: selectedTopic,
              datalist: dataList, // Use dataList here
            ),
          ],
        ),
      )


    );
  }
}
