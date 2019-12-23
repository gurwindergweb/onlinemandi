import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:onlinemandi/providers/weights.dart';

import '../models/http_exception.dart';
import './product.dart';
import 'database.dart';
import 'intercept.dart';
import 'weight.dart';

class Products extends Intercept with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  // var _showFavoritesOnly = false;
  String authToken;
  String userId;

  Products(String authToken, String userId, List<Product> items) : super(authToken, userId){
    this.authToken = authToken;
    this.userId = userId;
    this._items = items;
    print("productsssssssss");

  }
  var dbprovider = DBProvider();

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
  Product find(String id,grade) {
    return _items.firstWhere((prod) => prod.id == id && prod.grade == grade);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
  Future<void> fetchAndSetProducts(int type, Weights weightModel, [bool filterByUser = false]) async {
    //final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = GlobalConfiguration().getString("baseURL") + 'fruits/index2?status=22';
    final response = await dio.get(url);//await http.get(url);
    try {
      final response = await dio.get(url);//await http.get(url);
      final extractedData = response.data['fruits'];
      final favData = response.data['fav'];
      // print(response.data['fruits']);
      //if (extractedData == null) {
      //  return;
      //}
      //url = 'https://flutter-update.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      //final favoriteResponse = await http.get(url);
      //final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodData) async {

        if(prodData['rate_a']!=null){
          createProduct(prodData: prodData,grade: 0,favData: favData,weightModel: weightModel).then((data){
            loadedProducts.add(data);
          });

        }
        if(prodData['rate_b']!=null){
          createProduct(prodData: prodData,grade: 1,favData: favData,weightModel: weightModel).then((data){
            loadedProducts.add(data);
          });

        }
        if(prodData['rate_a']==null && prodData['rate_b']==null){
          createProduct(prodData: prodData,grade: -1,favData: favData,weightModel: weightModel).then((data){
            loadedProducts.add(data);
          });
        }
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
  Future<void> fetchAndSetVegetables(int type, Weights weightModel, [bool filterByUser = false]) async {
    //final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = GlobalConfiguration().getString("baseURL") + 'vegetables/index?status=22';
    final response = await dio.get(url);//await http.get(url);
    try {
      final response = await dio.get(url);//await http.get(url);
      final extractedData = response.data['vegetables'];
      final favData = response.data['fav'];
      //if (extractedData == null) {
      //  return;
      //}
      //url = 'https://flutter-update.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      //final favoriteResponse = await http.get(url);
      //final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      print(extractedData);
      extractedData.forEach((prodData) async {

        if(prodData['rate_a']!=null){
          createProduct(prodData: prodData,grade: 0,favData: favData,weightModel: weightModel).then((data){
            loadedProducts.add(data);
          });

        }
        if(prodData['rate_b']!=null){
          createProduct(prodData: prodData,grade: 1,favData: favData,weightModel: weightModel).then((data){
            loadedProducts.add(data);
          });

        }
        if(prodData['rate_a']==null && prodData['rate_b']==null){
          createProduct(prodData: prodData,grade: -1,favData: favData,weightModel: weightModel).then((data){
            loadedProducts.add(data);
          });
        }
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
  Future<Product> createProduct({prodData,grade,favData,weightModel}) async {
    prodData['rate_a'] == ''  ? prodData['rate_a'] = null : null;
    prodData['rate_b'] == ''  ? prodData['rate_b'] = null : null;
   return Product(
        id: prodData['id'].toString(),
        title: prodData['name'],
        description: prodData['hname'],
        price: grade == 0 ? double.parse(prodData['rate_a']): grade == 1 ? double.parse(prodData['rate_b']) : 0,
        isFavorite: favData.contains(prodData['id']) ? true : false,
        grade: grade,
        imageUrl: prodData['img'],
        selectedweight: prodData['selectedweight'].toString(),
        weights: await createWeightList(prodData['weights'],weightModel)
    );
  }
 Future<List> createWeightList(List weightList, Weights weightModel) async {
    List<ProductWeight> weights = [];
    List ww = weightModel.items;
    weightList.forEach((value){
     var weight = ww.firstWhere((wd) => wd.id == int.parse(value));
      weights.add(
          ProductWeight(id: value, name: weight.name + " " + weight.unit.sname)
      );
    });
  return await weights;
}
  Future<void> addProduct(Product product) async {
    final url =
        'https://flutter-update.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://flutter-update.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('Product not found');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutter-update.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
