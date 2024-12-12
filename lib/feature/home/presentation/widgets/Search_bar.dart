import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constant/constants.dart';

class searchBar extends StatefulWidget {
  const searchBar({super.key});

  @override
  State<searchBar> createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.height/40),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: ScreenSize.width / 30),
            child:  IconButton(
              onPressed: (){},
              icon:
              const Icon(Icons.search,
              color: Colors.grey,),
            ),

          ),
          fillColor: selectedCategory,
          filled: true,
          hintText: "ex: London",
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.width/10),
            borderSide: BorderSide.none
          )
        ),
      ),
    );
  }
}
