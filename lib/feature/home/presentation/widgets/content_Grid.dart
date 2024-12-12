import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:wonderlustapp/Core/models/modelsinterface.dart';
import '../../../../constant/constants.dart';

class content_grid extends StatefulWidget {
  const content_grid({super.key, required this.selectedTopic, required this.datalist,  });
  final String selectedTopic;
  final List <Modelsinterface> datalist ;
  
  
  
  
  
  @override
  State<content_grid> createState() => _content_gridState();
}

class _content_gridState extends State<content_grid> {

   void initState() {
    super.initState();
     _imageUrls = List.filled(widget.datalist.length, null,growable: false);
     _preloadImages();
  }
  String? imageUrl;

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url); // Convert the URL string to a Uri
    print("uri $uri");
    if (await canLaunchUrl(uri)) { // Check if the URL can be launched
      await launchUrl(uri); // Launch the URL
    } else {
      throw 'Could not launch $url'; // If it cannot be launched, throw an error
    }
  }
 List<String?> _imageUrls = [];
 Future<void> _preloadImages() async {
  for (var i = 0; i < widget.datalist.length; i++) {
    try {
      final link = widget.datalist[i].website;
      if (link.isNotEmpty) {
        final response = await http.get(Uri.parse(link));
        if (response.statusCode == 200) {
          var document = parse(response.body);
          var imageElement = document.querySelector('img');
          _imageUrls.add(imageElement?.attributes['src']);
        } else {
          _imageUrls.add(null); // Add null if image loading fails
        }
      }
    } catch (e) {
      _imageUrls.add(null); // Handle errors gracefully
    }
  }
  setState(() {}); // Trigger rebuild once all images are loaded
}
  @override
 
  @override
  Widget build(BuildContext context) {
    if (_imageUrls.isEmpty) {
    return const Center(child: CircularProgressIndicator());
  }
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.height/40),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0,
          ),
          itemCount: widget.datalist.length,
          itemBuilder: (context, index) {
           
            return InkWell(
              onTap: () {
                _launchURL(widget.datalist[index].website??'');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(ScreenSize.width/10),
                  image: DecorationImage(image: _imageUrls.length > index && _imageUrls[index] != null
          ? NetworkImage(_imageUrls[index]!)
          : const NetworkImage("https://www.istockphoto.com/photos/image-not-found"),fit: BoxFit.cover)
                ),
               
                child: Center(
                  child:Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ScreenSize.width/10),
                      color: const Color.fromARGB(24, 0, 0, 0)
                    ),
                    child:  Column(children: [
                      Text(widget.datalist[index].title??"No Title",style: TextStyle(color: mainColor,fontSize: 20),),
                     
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          Icon(Icons.star,size: 20,color: darkOlive,),
                          Text(widget.datalist[index].rating.toString()??'0.0',style: TextStyle(color: mainColor,fontSize: 20),),
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
                  )
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}
