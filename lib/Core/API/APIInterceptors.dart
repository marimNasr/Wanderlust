import 'package:dio/dio.dart';


class ApiInterceptors extends Interceptor {
  @override
  //options is the configuration of the request(headers)
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers ["Accept-Language"] = 'en';
    options.headers ["X-API-KEY"] = '6fb430a0d61e7ef0134ba5f9d0329646988a761a';
    options.headers [ 'Content-Type'] = 'application/json';
    
    super.onRequest(options, handler);
  }

}