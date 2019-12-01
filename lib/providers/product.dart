import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final bool quality;
  List weights;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.quality = true,
    this.isFavorite = false,
    this.weights,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  List<DropdownMenuItem> getWeightList(){
    List<DropdownMenuItem<String>> wList = [];
    this.weights.forEach((t) => {
    wList.add(
    DropdownMenuItem(
    value: t.id.toString(),
    child: new Text(t.name,style: TextStyle(color: Color(0xFF609f38),fontSize: 16),)
    )
    )
    });
    return wList;
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://flutter-update.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}

class ProductWeight{
  String id;
  String name;
  ProductWeight({@required this.id,@required this.name});

}
