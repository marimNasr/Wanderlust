import 'package:dio/dio.dart';


class ApiInterceptors extends Interceptor {
  @override
  //options is the configuration of the request(headers)
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers ["Accept-Language"] = 'en';
    super.onRequest(options, handler);
  }

}