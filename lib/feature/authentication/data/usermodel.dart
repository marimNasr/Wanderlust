import 'package:cloud_firestore/cloud_firestore.dart';

class  userModel{
  final String name;
  final String email;
  final String password;
  

  userModel({required this.name,required this.email,required this.password});
  factory userModel.fromJson(json){
    return userModel(
        name: json['name'],
        email: json['email'],
        password: json['password']);
  }
  

  static Future<userModel?>getUserByEmail(String email) async {
    try {
      // Reference to the collection
      final userCollection = FirebaseFirestore.instance.collection("User");

      // Query to find the document with the matching email
      final querySnapshot = await userCollection.where("email", isEqualTo: email).get();

      // Check if any document was found
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming you expect only one document per email
        final doc = querySnapshot.docs.first;

        // Map the document to userModel
        return userModel.fromJson(doc.data());
      } else {
        // No user found with the given email
        return null;
      }
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }

}