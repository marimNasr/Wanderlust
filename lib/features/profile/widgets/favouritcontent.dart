import 'package:flutter/material.dart';

import '../../../Constants/constant_color.dart';
import '../../../Constants/constant_size.dart';
import '../../../Core/models/modelsinterface.dart';


class favouriteContent extends StatefulWidget {
  const favouriteContent({super.key, required favoriteList, required this.datalist});
  final List <Modelsinterface> datalist ;

  @override
  State<favouriteContent> createState() => _favouriteContentState();
}

class _favouriteContentState extends State<favouriteContent> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
       scrollDirection: Axis.horizontal,
       itemCount: 5,
      itemBuilder: (BuildContext context, int index) { return Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(screenSize.width/10),
                  image: const DecorationImage(image:  NetworkImage("https://www.istockphoto.com/photos/image-not-found"),fit: BoxFit.cover)
                ),
               
                child: Center(
                  child:Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenSize.width/10),
                      color: const Color.fromARGB(24, 0, 0, 0)
                    ),
                    child:  Column(children: [
                      Text(widget.datalist[index].title,style: TextStyle(color: mainColor,fontSize: 20),),
                     
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          Icon(Icons.star,size: 20,color: darkOlive,),
                          Text(widget.datalist[index].rating as String,style: TextStyle(color: mainColor,fontSize: 20),),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [Icon(Icons.favorite_border,size: 20,color: darkOlive,)],
                             ),
                           )
                        ],),
                      )
                    ],),
                 )) ); },);
  }
}