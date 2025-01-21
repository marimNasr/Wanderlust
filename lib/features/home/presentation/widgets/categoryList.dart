import 'package:flutter/material.dart';
import '../../../../Constants/constant_color.dart';
import '../../../../Constants/constant_size.dart';
import '../../data/categories.dart';

class categoryList extends StatefulWidget {
  const categoryList({
    super.key,
    required this.selectedTopic,
    required this.onSelected
  });
  final String selectedTopic;
  final ValueChanged<String> onSelected;


  @override
  State<categoryList> createState() => _categoryListState();
}

class _categoryListState extends State<categoryList> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: screenSize.height / 11,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final bool isSelected = widget.selectedTopic == categories[index];

          return Padding(
            padding: EdgeInsets.only(top: screenSize.height / 60, bottom: screenSize.height / 60),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onSelected(categories[index]);
                });
              },
              child: AnimatedContainer(
                margin: EdgeInsets.symmetric(horizontal: screenSize.width / 45),
                duration: const Duration(milliseconds: 200), // Smooth transition
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(horizontal: screenSize.width / 20),
                decoration: BoxDecoration(
                  color: isSelected ? selectedCategory : orange,
                  borderRadius: BorderRadius.circular(screenSize.width),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: screenSize.width/60,
                      offset: const Offset(2, 2),
                    )
                  ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
