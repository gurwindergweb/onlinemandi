import 'package:dio/dio.dart';

class Intercept{
  String authToken;
  String userId;
  Dio dio = Dio();
  Intercept(authToken, userId){
    this.authToken = authToken;
    this.userId = userId;
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          options.headers["X-Access-Token"] = authToken;
          options.headers["Authorization"] = "Bearer " + authToken;
          options.headers["Content-Type"] = "application/json";
          options.headers['X-Current-Time'] = 0;
          return options;
        },
        onResponse:(Response response) async {
          return response; // continue
        },
        onError: (DioError e) async {
          return  e;//continue
        }
    ));
  }
}