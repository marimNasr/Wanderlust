import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Constants/constant_color.dart';
import '../../../Constants/constant_size.dart';

class Editbar extends StatefulWidget {
  const Editbar({super.key, required this.hinttext});
 final String hinttext;
  @override
  State<Editbar> createState() => _searchBarState();
}

class _searchBarState extends State<Editbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.height/40),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: screenSize.width / 30),
            child:  IconButton(
              onPressed: (){},
              icon:
              const Icon(Icons.search,
              color: Colors.grey,),
            ),

          ),
          fillColor: selectedCategory,
          filled: true,
          hintText: widget.hinttext ,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenSize.width/10),
            borderSide: BorderSide.none
          )
        ),
      ),
    );
  }
}
