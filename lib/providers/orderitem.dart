import 'cart.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import './cart.dart';
import 'database.dart';
import 'intercept.dart';
class OrderItem with ChangeNotifier{
  final  id;
  final double orderAmount;
  final double shippingcharge;
  final double grandtotal;
  final List<CartItem> products;
  final  date;
  get getid{
    return id;
  }
  get getorderAmount{
    return orderAmount;
  }
  get getproducts{
    return products;
  }
  get getdate{
    return date;
  }

  OrderItem({
    @required this.id,
    @required this.orderAmount,
    @required this.shippingcharge,
    @required this.grandtotal,
    @required this.products,
    @required this.date,
  });

}