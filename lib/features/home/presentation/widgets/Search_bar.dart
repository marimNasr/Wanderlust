import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Constants/constant_color.dart';
import '../../../../Constants/constant_size.dart';
import '../cubit/home_cubit.dart';

class searchBar extends StatefulWidget {
  const searchBar({super.key});

  @override
  State<searchBar> createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width / 40),
      child: TextFormField(
        //controller: context.read<HomeCubit>().searchController,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: screenSize.width / 30),
            child: IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.search, color: Colors.grey),
            ),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              // Clear the search input
              context.read<HomeCubit>().searchController?.clear();
              context.read<HomeCubit>().getAttractions();
            },
          ),
          fillColor: selectedCategory,
          filled: true,
          hintText: "ex: London, England",
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenSize.width / 10),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {

        },
      ),
    );
  }
}