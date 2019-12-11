import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import './cart.dart';
import 'database.dart';
import 'intercept.dart';
import 'orderitem.dart';



class Orders extends Intercept with ChangeNotifier {

  List<OrderItem> orderslist = [];
  final String authToken;
  final String userId;

  Orders({this.authToken, this.userId,this.orderslist}) : super(authToken, userId);
final dio =Dio();
  List<OrderItem> get orders {
    return [...orderslist];
  }
  Future fetchAndSetOrders() async {
    final url = GlobalConfiguration().getString('baseURL')+'index/orders-detail';
    final response = await dio.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.data);

    if (extractedData == null) {
      return;
    }
    response.data.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          orderAmount: orderData['amount'],
          date: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                      id: item['id'],
                      totalprice: item['price'],
                      quantity: item['quantity'],
                      title: item['title'],
                    ),
              )
              .toList(),
        ),
      );
    });

    orderslist = loadedOrders.reversed.toList();
    notifyListeners();
  }


  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = GlobalConfiguration().getString('baseURL')+'cart/place-order';
    var order = [];
    cartProducts.forEach((cp){
      order.add(json.encode({
        'id': cp.id,
        'w': cp.quantity,
        'g': '',
      }));
    });
    final timestamp = DateTime.now();
   var response = await dio.post(url,data: {'cart': order,'pm': 1});
    print('response');
    if(response.statusCode == 500){
      print(response.data);
    }

    /*final response = await http.post(
      url,
      body: json.encode({
        'orderAmount': total,
        'date': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.totalprice,
                })
            .toList(),
      }),
    );*/
    /*orderslist.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        orderAmount: total,
        date: timestamp,
        products: cartProducts,
      ),
    );*/
    notifyListeners();
  }
  Future updateOrder(oid) async {
    var url = GlobalConfiguration().getString('baseURL')+'cart/update-order';
    var order = orderslist.firstWhere((o) =>  o.id == oid);
    var orderdata = {
      'id': order.id,
      'orderAmount': order.orderAmount,
      'shippingcharge': order.shippingcharge,
      'grandtotal': order.grandtotal,
      'products': order.products,
      'date': order.date,

    };

    var response = await dio.post(url, data: {'cart': json.encode(orderdata), 'pm': 1, 'oid': oid});
    print(response);

  }
  Future getActiveOrders() async {
    final url = GlobalConfiguration().getString('baseURL')+'index/active-orders';
    final response = await dio.get(url);
    final List<OrderItem> loadedOrders = [];
    response.data['o'].forEach((orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderData['id'],
          orderAmount: double.parse(orderData['pt']),
          shippingcharge: double.parse(orderData['dc']),
          grandtotal: double.parse(orderData['gt']),
          date: orderData['date'].toString(),
          products: (orderData['items'] as List<dynamic>)
              .map(
                (item)  {
                  return CartItem(
                      id: item['pid'].toString(),
                      title: item['n'].toString(),
                      quantity:  item['q'],
                      grade: item['g'],
                      totalprice: double.parse(item['tp']),
                      discountrate: double.parse(item['dr']),

                      rate: double.parse(item['r']),
                      unit: item['u'],
                      image: item['img']

                  );
                },
          ).toList(),
        ),
      );
    });
    var od = Orders(authToken: authToken,userId: userId,orderslist: loadedOrders);
    od.orderslist = loadedOrders.reversed.toList();

    orderslist = loadedOrders.reversed.toList();
    print('loadedOrders');
    print(orderslist);
    notifyListeners();
    return response.data;
  }
  Future getCompletedOrders() async {
    final url = GlobalConfiguration().getString('baseURL')+'index/completed-orders';
    final response = await dio.get(url);
    final List<OrderItem> loadedOrders = [];
    response.data['o'].forEach((orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderData['id'],
          orderAmount: double.parse(orderData['pt']),
          shippingcharge: double.parse(orderData['dc']),
          grandtotal: double.parse(orderData['gt']),
          date: orderData['date'].toString(),
          products: (orderData['items'] as List<dynamic>)
              .map(
                (item)  {
              return CartItem(
                  id: item['pid'].toString(),
                  title: item['n'].toString(),
                  quantity:  item['q'],
                  grade: item['g'],
                  totalprice: double.parse(item['tp']),
                  discountrate: double.parse(item['dr']),

                  rate: double.parse(item['r']),
                  unit: item['u'],
                  image: item['img']

              );
            },
          ).toList(),
        ),
      );
    });
    var od = Orders(authToken: authToken,userId: userId,orderslist: loadedOrders);
    od.orderslist = loadedOrders.reversed.toList();

    orderslist = loadedOrders.reversed.toList();
    notifyListeners();
    return response.data;
  }
  Future getCanceledOrders() async {
    final url = GlobalConfiguration().getString('baseURL')+'index/cancelled-orders';
    final response = await dio.get(url);
    final List<OrderItem> loadedOrders = [];
    response.data['o'].forEach((orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderData['id'],
          orderAmount: double.parse(orderData['pt']),
          shippingcharge: double.parse(orderData['dc']),
          grandtotal: double.parse(orderData['gt']),
          date: orderData['date'].toString(),
          products: (orderData['items'] as List<dynamic>)
              .map(
                (item)  {
              return CartItem(
                  id: item['pid'].toString(),
                  title: item['n'].toString(),
                  quantity:  item['q'],
                  grade: item['g'],
                  totalprice: double.parse(item['tp']),
                  discountrate: double.parse(item['dr']),

                  rate: double.parse(item['r']),
                  unit: item['u'],
                  image: item['img']

              );
            },
          ).toList(),
        ),
      );
    });
    var od = Orders(authToken: authToken,userId: userId,orderslist: loadedOrders);
    od.orderslist = loadedOrders.reversed.toList();

    orderslist = loadedOrders.reversed.toList();
    notifyListeners();
    return response.data;
  }
  Future cancelOrder(id) async {
    final url = GlobalConfiguration().getString('baseURL')+'cart/cancel-order';
    final response = await dio.post(url,data:{"oid":"$id"});
    return response.data;
  }
  findOrderbyid(oid){
    return orders.firstWhere((order) =>order.id == oid);
  }
}
class GetOrder extends Intercept with ChangeNotifier{

  GetOrder(authToken, userId) : super(authToken, userId);
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }
  Future getOrders() async {
    final url = GlobalConfiguration().getString('baseURL')+'index/orders-detail';
    final List<OrderItem> loadedOrders = [];
    final response = await dio.get(url);
    return response.data;

  }
  Future getActiveOrders() async {
    final url = GlobalConfiguration().getString('baseURL')+'index/active-orders';
    final response = await dio.get(url);
    final List<OrderItem> loadedOrders = [];
     response.data['o'].forEach((orderData) {

          loadedOrders.add(
            OrderItem(
              id: orderData['id'],
              orderAmount: double.parse(orderData['gt']),
              date: orderData['date'].toString(),
              products: (orderData['items'] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                  id: item['pid'].toString(),
                  totalprice: double.parse(item['tp']),
                  quantity: item['q'],
                  title: item['n'],
                ),
              ).toList(),
            ),
          );
        });
       var od = Orders(authToken: authToken,userId: userId,orderslist: loadedOrders);
       od.orderslist = loadedOrders.reversed.toList();
       print('loadedOrders');
       print(loadedOrders);
        _orders = loadedOrders.reversed.toList();
        notifyListeners();
    return response.data;
  }
  Future getCompletedOrders() async {
    final url = GlobalConfiguration().getString('baseURL')+'index/completed-orders';
    final response = await dio.get(url);
    return response.data;
  }
  Future getCanceledOrders() async {
    final url = GlobalConfiguration().getString('baseURL')+'index/cancelled-orders';
    final response = await dio.get(url);
    return response.data;
  }
  Future cancelOrder(id) async {
    final url = GlobalConfiguration().getString('baseURL')+'cart/cancel-order';
    final response = await dio.post(url,data:{"oid":"$id"});
    return response.data;
  }

}

