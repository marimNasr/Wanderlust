import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation/Constants/constant_size.dart';

class content_grid extends StatefulWidget {
  const content_grid({super.key, required this.selectedTopic});
  final String selectedTopic;

  @override
  State<content_grid> createState() => _content_gridState();
}

class _content_gridState extends State<content_grid> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(screenSize.height/40),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(screenSize.width/10),
              ),
              child: Center(
                child: Text('Item ${widget.selectedTopic}'),
              ),
            );
          },
        ),
      ),
    );
  }

}
