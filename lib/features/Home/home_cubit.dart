import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/Core/API/Endpoints.dart';
import 'package:graduation/Core/models/HotelsModel.dart';
import '../../Core/API/APIConsumer.dart';
import '../../Core/API/dioConsumer.dart';
import '../../Core/errors/Exception.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  APIConsumer api = DioConsumer(dio: Dio());

  // Make the method async and await the response properly
  Future<void> getHotels(String city) async {
    try {
      emit(HotelLoading());
      final res = await api.get(
        "",
        queryParameters: {
          "engine": Endpoints.hotelsEngine,
          "q": city,
          "check_in_date": DateTime.now().toString(),
          "check_out_date": (DateTime.now().add(const Duration(days: 2))).toString(),
          "api_key": APIKey
        },
      );

      if (res != null) {
        HotelsResponseModel hotelsResponseModel = HotelsResponseModel.fromJson(res);
        emit(HotelSuccess());
        // Safely log the first hotel name if available
        if (hotelsResponseModel.hotels.isNotEmpty) {
          log('First Hotel: ${hotelsResponseModel.hotels[0].name}\n ${hotelsResponseModel.hotels[0].originalImage} \n ${hotelsResponseModel.hotels[0].link}\n ${hotelsResponseModel.hotels[0].overallRate}');
          log('second Hotel: ${hotelsResponseModel.hotels[1].name}\n ${hotelsResponseModel.hotels[1].originalImage} \n ${hotelsResponseModel.hotels[1].link}\n ${hotelsResponseModel.hotels[1].overallRate}');

        } else {
          log('No hotels found.');
        }
      } else {
        log('Error: Response is null.');
      }
    } on ServerException catch (e) {
      emit(HotelError(e.errorModel.message));
      log('Server Exception: ${e.errorModel.message}');
    }
  }
}
