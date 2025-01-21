import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/API/APIConsumer.dart';
import '../../../../Core/API/dioConsumer.dart';
import '../../../../Core/errors/Exception.dart';
import '../../../../Core/models/Attractionsmodel.dart';
import '../../../../Core/models/HotelsModel.dart';
import '../../../../Core/models/RestaurantsModel.dart';
import '../../../../Core/models/airportmodel.dart';
import '../../../../Core/models/modelsinterface.dart';




part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Modelsresponseinterface? modellistinterface ;
  APIConsumer api = DioConsumer(dio: Dio());

  //search bar controller with default value
  TextEditingController? searchController = TextEditingController(text: "London");
  //get hotels
  Future<List<Modelsinterface>> getHotels({int pageNumber = 1}) async {
    try {
      emit(HotelLoading());
      final res = await api.get(
        "",
        queryParameters: {
          "q": "hotels in ${searchController!.text}",
          "location": searchController!.text,
          "page": pageNumber
        },
      );

      if (res != null) {
        final hotels = Hotelsresponsemodel.fromJson(res);
        emit(HotelSuccess());
        return hotels.models; // Return the list of hotels
      }
      return [];
    } on ServerException catch (e) {
      emit(HotelError(e.errorModel.message));
      throw Exception('Server Exception: ${e.errorModel.message}');
    }
  }

//get restaurants
  Future<List<Modelsinterface>> getRestaurants({int pageNumber = 1}) async {
    try {
      emit(RestaurantLoading());
      final res = await api.get(
        "",
        queryParameters: {
          "q": "restaurants in ${searchController!.text}",
          "location": searchController!.text,
          "page": pageNumber
        },
      );

      if (res != null) {
        final restaurants = Restaurantsresponsemodel.fromJson(res);
        emit(RestaurantSuccess());
        return restaurants.models; // Return the list of restaurants
      }
      return [];
    } on ServerException catch (e) {
      emit(RestaurantError(e.errorModel.message));
      throw Exception('Server Exception: ${e.errorModel.message}');
    }
  }

//get attractions
  Future<List<Modelsinterface>> getAttractions({ int pageNumber = 1}) async {
    try {
      emit(AttractionLoading());
      final res = await api.get(
        "",
        queryParameters: {
          "q": "popular destinations in ${searchController!.text}",
          "location": searchController!.text,
          "page": pageNumber
        },
      );

      if (res != null) {
        final attractions = Attractionsresponsemodel.fromJson(res);
        emit(AttractionSuccess());
        return attractions.models; // Return the list of attractions
      }
      return [];
    } on ServerException catch (e) {
      emit(AttractionError(e.errorModel.message));
      throw Exception('Server Exception: ${e.errorModel.message}');
    }
  }

//get airports
  Future<List<Modelsinterface>> getAirports({ int pageNumber = 1}) async {
    try {
      emit(AirportLoading());
      final res = await api.get(
        "",
        queryParameters: {
          "q": "Airports in ${searchController!.text}",
          "location": searchController!.text,
          "page": pageNumber
        },
      );

      if (res != null) {
        final airports = Airportsresponsemodel.fromJson(res);
        emit(AirportSuccess());
        return airports.models; // Return the list of airports
      }
      return [];
    } on ServerException catch (e) {
      emit(AirportError(e.errorModel.message));
      throw Exception('Server Exception: ${e.errorModel.message}');
    }
  }

}
