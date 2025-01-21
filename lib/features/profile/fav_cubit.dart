import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());
   TextEditingController email = TextEditingController();

    Future<void> fetchFavourites() async {
    try {
      // Emit loading state while fetching data
      emit(FavLoading());

      // Reference to the User collection
      final userCollection = FirebaseFirestore.instance.collection("User");

      // Query to find the document with the matching email
      final querySnapshot = await userCollection.where("email", isEqualTo: email.text).get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first;
        final favourites = userDoc['favourite'];

        // Emit the favourites list to the UI
        emit(FavSuccess(favourites: {}));
      } else {
        emit(Favfail(error: 'Not Favourites'));
      }
    } catch (e) {
      emit(Favfail( error: e.toString()));
    }
  }
   Future<void> addFavourite(Map<String, dynamic> favouriteItem) async {
    try {
      // Reference to the User collection
      final userCollection = FirebaseFirestore.instance.collection("User");

      // Query to find the document with the matching email
      final querySnapshot = await userCollection.where("email", isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first;

        // Update the 'favourite' field in the user's document
        await userDoc.reference.update({
          'favourite': favouriteItem,  // Assuming favouriteItem is a Map<String, dynamic>
        });
      }
    } catch (e) {
      print("Error adding favourite: $e");
    }
  }

  List<String> favoriteItems = []; // Use a list to store favorite items (replace String with your model)

  void toggleFavorite(String item) {
    if (favoriteItems.contains(item)) {
      favoriteItems.remove(item); // Remove from favorites
    } else {
      favoriteItems.add(item); // Add to favorites
    }
    emit(FavSuccess( favourites: const {})); // Update the state to reflect changes
  }

}
