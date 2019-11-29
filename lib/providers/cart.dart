import 'package:flutter/foundation.dart';

import 'database.dart';

class CartItem with ChangeNotifier{
  final String id;
  final String title;
  int quantity;
  final String grade;
  final double totalprice;
  final double discountrate;
  final double rate;
  final String unit;
  final String image;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.grade,
    @required this.totalprice,
    @required this.discountrate,
    @required this.rate,
    @required this.unit,
    @required this.image,
  }){
    this.getweight(this.quantity );
  }
  setquantity(q) {
    quantity = int.parse(q);
    notifyListeners();
  }
  getweight(w) async {
    var dbprovider = DBProvider();
    //var dbclient = await dbprovider.database;

    var weightdata = await dbprovider.getweight(w);
    setquantity(weightdata[0]['name']);



  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.totalprice * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              totalprice: existingCartItem.totalprice,
              quantity: existingCartItem.quantity + 1,
            ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              totalprice: price,
              quantity: 1,

            ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                totalprice: existingCartItem.totalprice,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
