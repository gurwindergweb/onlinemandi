import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:onlinemandi/providers/intercept.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';

class Utilities extends Intercept with ChangeNotifier{
  Utilities(authToken, userId) : super(authToken, userId);
  Future checkoldpass(String password) async {
    var url = GlobalConfiguration().getString('baseURL')+'index/check-password?pw='+password;
    try{
      final response = await dio.get(url);
      return response.data['result'];
    }
    on DioError catch(error){
      print(error.request.headers);
      // return error;
    }
    /*if(response.statusCode == 401){
      return 'unauthorised';
    }
    else{
      return 'success';
    }*/
  }
  Future changepassword(String password) async {
    var url = GlobalConfiguration().getString('baseURL')+'index/change-password';
    final response =  await dio.post(url, data: {"pw": password});
    print(response);
    if(response.statusCode == 200){
      return 'success';
    }
    else{
      return response;

    }
  }
  Future changenumber(String contact1, String contact2) async {
    var url = GlobalConfiguration().getString('baseURL') + 'index/update-numbers';
    final response = await dio.post(url,data: {'c1': contact1, 'c2': contact2});
    if(response.statusCode == 200){
      final responseData = response.data;

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
          {
            'token': responseData['access_token'],
            'username': responseData['username'],
            'email': responseData['details']['email'],
            'userId': responseData['details']['email'],
            'cityId': responseData['details']['cid'],
            'city': responseData['details']['city'],
            'contact1': responseData['details']['contact1'],
            'contact2': responseData['details']['contact2'],
            'sellerContact1': responseData['details']['scont1'],
            'sellerContact2': responseData['details']['scont2'],
            'serviceContact1': responseData['details']['c1'],
            'serviceContact2': responseData['details']['c2'],
            'joiningDate': responseData['details']['jd']
          }
      );
      prefs..setString('userData', userData);
      return 'success';

    }
    else{
      return response;
    }
  }

}