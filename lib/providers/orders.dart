import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import './cart.dart';
import 'intercept.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders extends Intercept with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders) : super(authToken, userId);
final dio =Dio();
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future fetchAndSetOrders() async {
    final url = GlobalConfiguration().getString('baseURL')+'index/orders-detail';
    final response = await dio.get(url);
    final List<OrderItem> loadedOrders = [];
    print('response');
    print(response.data);
    final extractedData = json.decode(response.data);

    if (extractedData == null) {
      return;
    }
    print(extractedData);
    print('respoonse end');
    response.data.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                      id: item['id'],
                      price: item['price'],
                      quantity: item['quantity'],
                      title: item['title'],
                    ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }


  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://flutter-update.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
class GetOrder extends Intercept with ChangeNotifier{
  GetOrder(authToken, userId) : super(authToken, userId);


  Future getOrders() async {
    final url = GlobalConfiguration().getString('baseURL')+'index/orders-detail';
    final response = await dio.get(url);
    return response.data;
  }
}

