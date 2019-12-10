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
  List<Unit> _unitItems = [];

  String authToken;
  String userId;
  var dbprovider = DBProvider();
  Weights(String authToken, String userId)
      : super(authToken, userId) {
    this.authToken = authToken;
    this.userId = userId;
    this.fetchAndSetWeights();
    print("hellooooooooo");
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
  Future <void> fetchAndSetUnits() async {
    var unitsurl = GlobalConfiguration().getString("baseURL") + 'index/units';
    List loadedUnits = List();
    var dbclient = await dbprovider.database;
    dbprovider.getAllRecords('Unit').then((unitData) async{
      if(unitData.length > 0){
        unitData.forEach((unitModel){
          _unitItems.add(
              Unit(
                id: unitModel['id'],
                name: unitModel['name'],
                sname: unitModel['sname'],
              ));
        });
      } else {
        final unitresponse = await dio.get(unitsurl);
        final extractedunit = unitresponse.data;
        await extractedunit.forEach((unitModel){
          loadedUnits.add({
            "id": unitModel['id'],
            "name": unitModel['name'],
            "sname": unitModel['sname'],
            "status": unitModel['status'],
          });
          _unitItems.add(
              Unit(
                id: unitModel['id'],
                name: unitModel['name'],
                sname: unitModel['sname'],
              ));
        });
        await DeleteTable("Unit");
        loadedUnits.forEach((udata) async{
          await dbclient.insert("Unit", udata);
        });
      }
    });
  }




  Future<void> fetchAndSetWeights() async {
    var weightsurl = GlobalConfiguration().getString("baseURL") + 'index/weights';
    await fetchAndSetUnits();
    List loadedWeights = List();
    var dbclient = await dbprovider.database;
    dbprovider.getAllRecords('Weight').then((data) async{
      print("in fetchandset weights");
      if(data.length > 0){
          data.forEach((weightModel) {
            _items.add(Weight(
              id: weightModel['id'],
              name: weightModel['name'].toString(),
              unitId: weightModel['unitId'],
              depends: weightModel['depends'],
              multiplier: weightModel['multiplier'].toDouble(),
              unit: _unitItems.firstWhere((u) => u.id == weightModel['unitId']),
            ));
          });
      } else {
        try {

          final response = await dio.get(weightsurl);
          final extractedData = response.data;

          await extractedData.forEach((weightModel) {
            loadedWeights.add({
              "id": weightModel['id'],
              "name": weightModel['name'].toString(),
              "unitId": weightModel['unitId'],
              "depends": weightModel['depends'],
              "multiplier": weightModel['multiplier'].toDouble(),
            });
            _items.add(Weight(
              id: weightModel['id'],
              name: weightModel['name'].toString(),
              unitId: weightModel['unitId'],
              depends: weightModel['depends'],
              multiplier: weightModel['multiplier'].toDouble(),
              unit: _unitItems.firstWhere((u) => u.id == weightModel['unitId'])
            ));
          });
          await DeleteTable("Weight");
          await loadedWeights.forEach((data) async {
            await dbclient.insert("Weight",data);
          });
        } catch (error) {
          throw (error);
        }
      }
    });
  }
  Future<int> DeleteTable(table) async {
    var dbClient = await dbprovider.database;
    int res = await dbClient.delete(table);
    return res;
  }
  getweightbyid(id){
   return _items.firstWhere((item) =>item.id == id);
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