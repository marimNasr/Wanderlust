import 'package:dio/dio.dart';
import '../errors/Exception.dart';
import 'APIConsumer.dart';
import 'APIInterceptors.dart';
import 'Endpoints.dart';

class DioConsumer  extends APIConsumer {
  final Dio dio;

  DioConsumer({required this.dio}){
    dio.options.baseUrl = Endpoints.baseUrl;
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      requestBody: true,
    ));
    //any header written in ApiInterceptors will be sent automatically with the request
    dio.interceptors.add(ApiInterceptors());
  }
  @override
  delete(String path, {dynamic data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    try {
      final response = await dio.delete(
          path, data: isFormData== true ? FormData.fromMap(data) : data, queryParameters: queryParameters);
      return response.data;
    }on DioException catch (e) {
      handelException(e);

    }
  }


  @override
  get(String path, {Object? data, Map<String, dynamic>? queryParameters}) async{
    try {
      final response = await dio.get(
          path, data: data, queryParameters: queryParameters);
      return response.data;
    }on DioException catch (e) {
      handelException(e);

    }  }

  @override
  patch(String path, {dynamic data, Map<String, dynamic>? queryParameters,bool isFormData = false}) async{
    try {
      final response = await dio.patch(
          path, data:isFormData== true ? FormData.fromMap(data) : data, queryParameters: queryParameters);
      return response.data;
    }on DioException catch (e) {
      handelException(e);

    }  }

  @override
  post(String path, {dynamic data, Map<String, dynamic>? queryParameters,bool isFormData = false}) async{
    try {
      final response = await dio.post(
          path, data: isFormData== true ? FormData.fromMap(data) : data, queryParameters: queryParameters);
      return response.data;
    }on DioException catch (e) {
      handelException(e);

    }  }

}