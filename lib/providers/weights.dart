import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';
import './weight.dart';
import 'database.dart';
import 'intercept.dart';

class Weights extends Intercept with ChangeNotifier {
  List<Weight> _items = [];

  String authToken;
  String userId;
  var dbprovider = DBProvider();
  Weights(String authToken, String userId)
      : super(authToken, userId) {
    this.authToken = authToken;
    this.userId = userId;
  }


  /*Future<bool> fetchAndSetWeights() async {
    //final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = GlobalConfiguration().getString("baseURL") + 'index/weights';
    try {
      final response = await dio.get(url);//await http.get(url);
      //print(response);
      final extractedData = response.data;
      print("Weights:");
      print(response.data);
      //if (extractedData == null) {
      //  return;
      //}
      //url = 'https://flutter-update.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      //final favoriteResponse = await http.get(url);
      //final favoriteData = json.decode(favoriteResponse.body);
      List loadedWeights = List();
      extractedData.forEach((prodData) {
        print(prodData);
        loadedWeights.add({
          "id": prodData['id'],
          "name": prodData['name'].toString(),
          "unitId": prodData['unitId'],
          "depends": prodData['depends'],
          "multiplier": prodData['multiplier'].toDouble(),
        });
      });

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('weightData', json.encode(loadedWeights));
      //prefs.clear();
      return true;
    } catch (error) {
      throw (error);
    }
  }*/
  Future<bool> fetchAndSetWeights() async {
    //final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = GlobalConfiguration().getString("baseURL") + 'index/weights';
    var weight;
    try {
      final response = await dio.get(url);//await http.get(url);
      //print(response);
      final extractedData = response.data;

      List loadedWeights = List();

      extractedData.forEach((prodData) {
        loadedWeights.add({
          "id": prodData['id'],
          "name": prodData['name'].toString(),
          "unitId": prodData['unitId'],
          "depends": prodData['depends'],
          "multiplier": prodData['multiplier'].toDouble(),
        });
        /*_items.add(Weight(
          id: prodData['id'],
          name: prodData['name'].toString(),
          unitId: prodData['unitId'],
          depends: prodData['depends'],
          multiplier: prodData['multiplier'].toDouble(),
        ));*/
      });
      //final prefs = await SharedPreferences.getInstance();
      //prefs.setString('weightData', );
     // prefs.clear();
      var dbclient = await dbprovider.database;
     var weightdata = await dbprovider.getAllRecords('Weight');
       await DeleteWeight();
       await loadedWeights.forEach((data) async {
         var res = await dbclient.insert("Weight",data);
       });
       weightdata = await dbprovider.getAllRecords('Weight');
      // weightdata.where((wd)=>wd['id'] ==1)


       return true;
    } catch (error) {
      throw (error);
    }
  }
  Future<int> DeleteWeight() async {
    var dbClient = await dbprovider.database;
    int res = await dbClient.delete("Weight");
    return res;
  }
  Future<bool> createWeights() async {
    final prefs = await SharedPreferences.getInstance();
    json.decode(prefs.getString('weightData'));

  }




  List<Weight> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }
}