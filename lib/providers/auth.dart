import 'dart:async' as prefix0;
import 'dart:convert';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:onlinemandi/providers/weight.dart';
import 'package:onlinemandi/providers/weights.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:global_configuration/global_configuration.dart';
import '../models/http_exception.dart';
import 'intercept.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';
class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  String _email;
  String _username;
  int _cityId;
  String _city;
  String _joiningDate;
  String _contact1;
  String _contact2;
  String _sellerContact1;
  String _sellerContact2;
  String _serviceContact1;
  String _serviceContact2;
  Timer _authTimer;
  List<DropdownModel> _states = [];
  List<DropdownModel> _cities = [];
  List<DropdownModel> _emptyCities = [];
  final dio = new Dio();
  static Database _db;

  bool get isAuth {
    return token != null;
  }
  List<DropdownModel> get states {
    return [..._states];
  }
  List<DropdownModel> get cities {
    return [..._cities];
  }

  List<DropdownModel> get emptyCities {
    return [..._emptyCities];
  }
  String get token {
    /*if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {*/
    if(_token != null){
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }
  Future<void> _authenticate( String email, String password) async {
    final url = GlobalConfiguration().getString("baseURL") + 'index/login';
    try {
      final response = await http.post(
        url,
        body: {'username': email, 'password': password },

      );
      final responseData = json.decode(response.body);
      if (responseData['result'] != 1) {
        throw HttpException('Login failed, please try again.');
      }
      print(responseData);
      _username = responseData['username'];
      _token = responseData['access_token'];
      _userId = responseData['details']['email'];
      _email = responseData['details']['email'];
      _cityId =  responseData['details']['cid'];
      _city = responseData['details']['city'];
      _joiningDate = responseData['details']['jd'];
      _contact1 = responseData['details']['contact1'];
      _contact2 = responseData['details']['contact2'];
      _sellerContact1 = responseData['details']['scont1'];
      _sellerContact2 = responseData['details']['scont2'];
      _serviceContact1 = responseData['details']['c1'];
      _serviceContact2 = responseData['details']['c2'];
     /* _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );*/
      //_autoLogout();
      final prefs = await SharedPreferences.getInstance();
      Weights weightsObj = new Weights(_token, _userId);
      await weightsObj.fetchAndSetWeights();
      //print(weights);
      //final weightData = json.encode(weights);

      final userData = json.encode(
        {
          'token': _token,
          'username': _username,
          'email': _email,
          'userId': _userId,
          'cityId': _cityId,
          'city': _city,
          'contact1': _contact1,
          'contact2': _contact2,
          'sellerContact1': _sellerContact1,
          'sellerContact2': _sellerContact2,
          'serviceContact1': _serviceContact1,
          'serviceContact2': _serviceContact2,
          'joiningDate': _joiningDate
        }
      );
      prefs..setString('userData', userData);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getStates() async {
    var url = GlobalConfiguration().getString("baseURL") + 'index/allstates';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        return;
      }
      final List<DropdownModel> loadedStates = [];
      extractedData.forEach((prodData) {
        loadedStates.add(DropdownModel(
          id: prodData['value'],
          name: prodData['title'],
        ));
      });
      _states = loadedStates;
      //notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
  Future<void> getCities(int entity) async {

    var url = GlobalConfiguration().getString("baseURL") + 'index/cities?state_id=' + entity.toString();
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        return;
      }
      final List<DropdownModel> loadedCities = [];
      extractedData.forEach((data) {
        loadedCities.add(DropdownModel(
          id: data['value'],
          name: data['title'],
        ));
      });
      _cities = loadedCities;
      //notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
  Future<void> signup(String name,String email, String phone, String city, String password) async {

    final url = GlobalConfiguration().getString("baseURL") + 'index/register-newuser';
    try {
      final response = await http.post(
        url,
        body: {'fname': name,'email': email,'phone': phone,'city': city, 'password': password },

      );
      final responseData = json.decode(response.body);
      print("res 22");
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['access_token'];
      _userId = responseData['email'];
      _cityId =  int.parse(responseData['cid']);
      _city = responseData['city'];
      _joiningDate = responseData['jd'];
      _contact1 = responseData['contact1'];
      _contact2 = responseData['contact2'];
      _sellerContact1 = responseData['scont1'];
      _sellerContact2 = responseData['scont2'];
      _serviceContact1 = responseData['c1'];
      _serviceContact2 = responseData['c2'];
      /* _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );*/
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'cityId': _cityId,
          'city': _city,
          'contact1': _contact1,
          'contact2': _contact2,
          'sellerContact1': _sellerContact1,
          'sellerContact2': _sellerContact2,
          'serviceContact1': _serviceContact1,
          'serviceContact2': _serviceContact2,
          'joiningDate': _joiningDate,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }







    return _authenticate(email, password);
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> _getOrSetWeights(int weight_version) async{
    final prefs = await SharedPreferences.getInstance();
    Weights weightsObj = new Weights(_token, _userId);
    if (!prefs.containsKey('weightData')) {
     // List weights = await weightsObj.fetchAndSetWeights();
    } else {
     // List weights = await weightsObj.getWeights();
    }


  }
}
class DropdownModel {
  final int id;
  final String name;

  DropdownModel({
    @required this.id,
    @required this.name,
  });
}