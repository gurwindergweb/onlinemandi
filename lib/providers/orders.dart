import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './cart.dart';
import 'database.dart';
import 'intercept.dart';
import 'orderitem.dart';
import 'weight.dart';
import 'weights.dart';



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


  Future addOrder(List<CartItem> cartProducts, double total,context) async {
    var weights = Provider.of<Weights>(context);
    var units = Provider.of<Weights>(context);

    //weights.items.firstWhere(test);
    final url = GlobalConfiguration().getString('baseURL')+'cart/place-order';
    var order = [];
    cartProducts.forEach((cp){
      var udata =units.unitItems.firstWhere((ud) =>ud.sname == cp.unit);
      var wdata = weights.items.firstWhere((wd) => wd.unitId == udata.id && wd.name == cp.quantity);
      order.add(json.encode({
        'id': cp.pId,
        'w': wdata.id,
        'g': cp.grade,
      }));
    });
    final timestamp = DateTime.now();
   var response = await dio.post(url,data: {'cart': order,'pm': 1});
   print(response.data);
    orderslist.insert(
      0,
      OrderItem(
        id: response.data['orderId'],
        orderAmount: total,
        date: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
    return response.data;
  }
  Future updateOrder(oid,context) async {
    var url = GlobalConfiguration().getString('baseURL')+'cart/update-order';
    var order = orderslist.firstWhere((o) =>  o.id == oid);
    var weights = Provider.of<Weights>(context);
    var units = Provider.of<Weights>(context);
    var productarr = [];
    order.products.forEach((op){
      var udata =units.unitItems.firstWhere((ud) =>ud.sname == op.unit);
      var wdata = weights.items.firstWhere((wd) => wd.unitId == udata.id && wd.name == op.quantity);
      productarr.add(json.encode({
        'id': op.id,
        'w': wdata.id,
        'g': op.grade,
      }));
    });


    var response = await dio.post(url, data: {'cart': productarr, 'pm': 1, 'oid': oid});
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
                      grade: item['g'] == 'A' ? 0: 1,
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

