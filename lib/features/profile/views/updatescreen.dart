import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Constants/constant_color.dart';
import '../../../Constants/constant_size.dart';
import '../fav_cubit.dart';
import '../widgets/editbar.dart';
import '../widgets/favouritcontent.dart';

class Updatescreen extends StatefulWidget {
  const Updatescreen({super.key});
  static String routename = "Updatescreen";

  @override
  State<Updatescreen> createState() => _UpdatescreenState();
}

class _UpdatescreenState extends State<Updatescreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavCubit>().fetchFavourites();
  }
  @override
  Widget build(BuildContext context) {
    screenSize.init_screenSize(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: orange,
        body: BlocConsumer<FavCubit, FavState>(
          listener: (context, state) {
            if (state is FavSuccess) {
      
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Favorites loaded successfully!")),
              );
            } else if (state is Favfail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Container(
              height: screenSize.height,
              width: screenSize.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenSize.width/2.5),
                ),
                color: mainColor,
              ),
              child: Stack(
                children: [Column(
                  children: [
                    SizedBox(height: 60,),
                    Row(
                      children: [
                        SizedBox(width: screenSize.width/10),
                        Row(
                          children: [
                            Text(
                              "Profile",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenSize.width/10.6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(width: screenSize.width/8,),
                            Image(image: AssetImage('assets/boat.png'),height: screenSize.height/6),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height / 10,
                    ),
                    const Editbar(
                      hinttext: 'name',
                    ),
                    SizedBox(
                      height: screenSize.height / 20,
                    ),
                    const Editbar(
                      hinttext: 'Email',
                    ),
                    SizedBox(
                      height: screenSize.height / 20,
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "Favourite List",
                          style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    state is FavSuccess
                        ? favouriteContent(favoriteList: state.favourites, datalist: [],)
                        : state is FavLoading
                        ? const CircularProgressIndicator() // Show a loader while loading
                        : const Text("No favorites found"),
                  ],
                ),
                  Positioned( // Back button positioned at the top left
                    top: screenSize.height/50,
                    left: screenSize.width/80,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop(); // Go back to the previous screen
                      },
                    ),
                  ),
                ]
              ),
            );
          },
        ),
      ),
    );
  }
}
