import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Weight with ChangeNotifier {
   int id;
   String name;
   int unitId;
   int depends;
   double multiplier;
   Unit unit;

  Weight({
    @required this.id,
    @required this.name,
    @required this.unitId,
    @required this.depends,
    @required this.multiplier,
    this.unit,
  });
  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["unitId"] = unitId;
    map["depends"] = depends;
    map["multiplier"] = multiplier;
    return map;
  }
  Weight.map(dynamic obj){
    this.id = obj["id"];
    this.name = obj["name"];
    this.unitId = obj["unitId"];
    this.depends = obj["depends"];
    this.multiplier = obj["multiplier"];
  }
  static Weight weightFromMap(Map obj) {

     Weight weight = Weight();
     weight.id = obj["id"];
     weight.name = obj["name"];
     weight.unitId = obj["unitId"];
     weight.depends = obj["depends"];
     weight.multiplier = obj["multiplier"];
     return weight;
   }
}
class Unit{
  int id;
  String name;
  String sname;
  Unit({
    @required this.id,
    @required this.name,
    @required this.sname,
  });
}