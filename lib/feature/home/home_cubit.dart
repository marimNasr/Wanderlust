import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonderlustapp/Core/models/Attractionsmodel.dart';
import 'package:wonderlustapp/Core/models/RestaurantsModel.dart';
import 'package:wonderlustapp/Core/models/airportmodel.dart';
import 'package:wonderlustapp/Core/models/modelsinterface.dart';
import '../../Core/API/APIConsumer.dart';
import '../../Core/API/dioConsumer.dart';
import '../../Core/errors/Exception.dart';
import '../../Core/models/HotelsModel.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Modelsresponseinterface? modellistinterface ;
  APIConsumer api = DioConsumer(dio: Dio());
//https://google.serper.dev/places?q=attractions&location=United+States&apiKey=6fb430a0d61e7ef0134ba5f9d0329646988a761a


  //get hotels
  Future<Modelsresponseinterface> getHotels({ String city="London",  int pageNumber=1}) async {
    try {
      emit(HotelLoading());
      final res = await api.get(
        "",
        queryParameters: {
          "q": "hotels in $city",
          "location": "United States",
          "page": pageNumber
        },
      );

      if (res != null) {
         modellistinterface = Hotelsresponsemodel.fromJson(res);
        emit(HotelSuccess());
      }
       return modellistinterface!;
        // Safely log the first hotel name if available
      //   if (modellistinterface!.models.isNotEmpty) {
      //     print('First Hotel: ${modellistinterface!.models[0].title}\n ${modellistinterface!.models[0].website}\n ${modellistinterface!.models[0].rating}');
      //     print('second Hotel: ${modellistinterface!.models[1].title}\n ${modellistinterface!.models[1].website}\n ${modellistinterface!.models[1].rating}');

      //   } else {
      //     log('No hotels found.');
      //   }
      // } else {
      //   log('Error: Response is null.');
      // }

    } on ServerException catch (e) {
      emit(HotelError(e.errorModel.message));
      throw Exception('Server Exception: ${e.errorModel.message}');
    }
  }

  //get restaurants

  Future<Modelsresponseinterface> getRestaurants({String city="London",  int pageNumber=1}) async {
    try {
      emit(RestaurantLoading());
      final res = await api.get(
        "",
        queryParameters: {
          "q": "restuarants in $city",
          "location": "$city ",
          "page": pageNumber
        },
      );

      if (res != null) {
         modellistinterface = Restaurantsresponsemodel.fromJson(res);
        emit(RestaurantSuccess());

        }
         return modellistinterface!;
        // Safely log the first hotel name if available
      //   if (modellistinterface!.models.isNotEmpty) {
      //     print('First Hotel: ${modellistinterface!.models[0].title}\n ${modellistinterface!.models[0].website}\n ${modellistinterface!.models[0].rating}');
      //     print('second Hotel: ${modellistinterface!.models[1].title}\n ${modellistinterface!.models[1].website}\n ${modellistinterface!.models[1].rating}');

      //   } else {
      //     log('No hotels found.');
      //   }
      // } else {
      //   log('Error: Response is null.');
      // }
    } on ServerException catch (e) {
      emit(RestaurantError(e.errorModel.message));
      throw Exception('Server Exception: ${e.errorModel.message}');
    }
  }
//get attractions
Future<Modelsresponseinterface> getAttractions({String city="London",  int pageNumber=1}) async {
    try {
      emit(AttractionLoading());
      final res = await api.get(
        "",
        queryParameters: {
          "q": "popular destinations in $city",
          "location": "$city ",
          "page": pageNumber
        },
      );

      if (res != null) {
         modellistinterface = Attractionsresponsemodel.fromJson(res);
        emit(AttractionSuccess());
        
        // Safely log the first hotel name if available
      //   if (modellistinterface!.models.isNotEmpty) {
      //     print('First Hotel: ${modellistinterface!.models[0].title}\n ${modellistinterface!.models[0].website}\n ${modellistinterface!.models[0].rating}');
      //     print('second Hotel: ${modellistinterface!.models[1].title}\n ${modellistinterface!.models[1].website}\n ${modellistinterface!.models[1].rating}');

      //   } else {
      //     log('No hotels found.');
      //   }
      // } else {
      //   log('Error: Response is null.');
      }
       return modellistinterface!;
    } on ServerException catch (e) {
      emit(AttractionError(e.errorModel.message));
      throw Exception('Server Exception: ${e.errorModel.message}');
    }
  }
   //get airports
  Future<Modelsresponseinterface> getAirports({String city="London",  int pageNumber=1}) async {
    try {
      emit(AirportLoading());
      final res = await api.get(
        "",
        queryParameters: {
          "q": "Airports in $city",
          "location": "$city ",
          "page": pageNumber
        },
      );

      if (res != null) {
         modellistinterface = Airportsresponsemodel.fromJson(res);
        emit(AirportSuccess());

        
        // Safely log the first hotel name if available
      //   if (modellistinterface!.models.isNotEmpty) {
      //     print('First Hotel: ${modellistinterface!.models[0].title}\n ${modellistinterface!.models[0].website}\n ${modellistinterface!.models[0].rating}');
      //     print('second Hotel: ${modellistinterface!.models[1].title}\n ${modellistinterface!.models[1].website}\n ${modellistinterface!.models[1].rating}');

      //   } else {
      //     log('No hotels found.');
      //   }
      // } else {
      //   log('Error: Response is null.');
      }
       return modellistinterface!;
    } on ServerException catch (e) {
      emit(AirportError(e.errorModel.message));
      throw Exception('Server Exception: ${e.errorModel.message}');
    }
  } 
}
