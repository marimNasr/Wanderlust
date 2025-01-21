import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Constants/constant_color.dart';
import 'package:html/parser.dart'; // For parsing HTML
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../../Constants/constant_size.dart';
import '../../../../Core/models/modelsinterface.dart';
import '../../../profile/fav_cubit.dart';

class ContentGrid extends StatefulWidget {
  const ContentGrid({
    super.key,
    required this.selectedTopic,
    required this.datalist,
  });
  final String selectedTopic;
  final List<Modelsinterface> datalist;

  @override
  State<ContentGrid> createState() => _ContentGridState();
}

class _ContentGridState extends State<ContentGrid> {
  final Map<String, String?> _imageCache = {}; // Cache for image URLs
  bool isClicked = true;

  void _launchURL(String url) async {
    try {
      if (url.isEmpty) {
        throw 'URL is empty.';
      }

      final Uri uri = Uri.parse(url); // Parse the URL string into a Uri object
      if (await canLaunchUrl(uri)) { // Check if the URL can be launched
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication, // Use an external application to open the URL
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open the URL.')),
      );
    }
  }

  bool isValidUrl(String url) {
    final Uri uri = Uri.tryParse(url) ?? Uri();
    return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(screenSize.height / 40),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0,
          ),
          itemCount: widget.datalist.length,
          itemBuilder: (context, index) {
            final item = widget.datalist[index];

            return InkWell(
              onTap: () {
                final url = widget.datalist[index].website ?? '';
                if (isValidUrl(url)) {
                  _launchURL(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid URL.')),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenSize.width / 20),
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FutureBuilder<String?>(
                      future: _fetchImageFromWebsite(item.website),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final imageUrl = snapshot.data;
                        if (imageUrl != null && Uri.tryParse(imageUrl)?.hasAbsolutePath == true) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(screenSize.width / 20),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/image-coming-soon.jpg',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          );
                        } else {
                          return Image.asset(
                            'assets/image-coming-soon.jpg',
                            fit: BoxFit.cover,
                          );
                        }
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5), // Apply a bigger blur to half of the container
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(screenSize.width / 20),
                            bottomRight: Radius.circular(screenSize.width / 20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                item.title ?? "No Title",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 18,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      item.rating.toString() ?? '0.0',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  color: greenHeart,
                                  onPressed: () {
                                    setState(() {
                                      isClicked = !isClicked; // Flip the heart icon when clicked
                                    });
                                    context.read<FavCubit>().addFavourite({
                                      "title": widget.datalist[index].title,
                                      "rating": widget.datalist[index].rating,
                                      "websitelink": widget.datalist[index].website,
                                    });
                                  },
                                  icon: isClicked
                                      ? Icon(Icons.favorite_border, size: 20)
                                      : Icon(Icons.favorite, size: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<String?> _fetchImageFromWebsite(String? websiteUrl) async {
    if (websiteUrl == null || websiteUrl.isEmpty) return null;
    if (_imageCache.containsKey(websiteUrl)) return _imageCache[websiteUrl];

    try {
      final response = await http.get(Uri.parse(websiteUrl));
      if (response.statusCode == 200) {
        final document = parse(response.body);

        // Check for 'og:image' meta tag
        final metaTags = document.getElementsByTagName('meta');
        for (var tag in metaTags) {
          if (tag.attributes['property'] == 'og:image' &&
              tag.attributes['content'] != null) {
            var imageUrl = tag.attributes['content'];
            if (imageUrl != null && Uri.tryParse(imageUrl)?.hasAbsolutePath == false) {
              imageUrl = Uri.parse(websiteUrl).resolve(imageUrl).toString();
            }
            _imageCache[websiteUrl] = imageUrl; // Cache the result
            return imageUrl;
          }
        }

        // Fallback: First <img> tag
        final imgTags = document.getElementsByTagName('img');
        if (imgTags.isNotEmpty) {
          var imageUrl = imgTags.first.attributes['src'];
          if (imageUrl != null && Uri.tryParse(imageUrl)?.hasAbsolutePath == false) {
            imageUrl = Uri.parse(websiteUrl).resolve(imageUrl).toString();
          }
          _imageCache[websiteUrl] = imageUrl; // Cache the result
          return imageUrl;
        }
      }
    } catch (e) {
      print('Error fetching image: $e');
    }

    _imageCache[websiteUrl] = null; // Cache failed attempts
    return null;
  }
}
