import 'package:flutter/foundation.dart';
import 'database.dart';

class CartItem with ChangeNotifier{
  final String id;
  final String pId;
  final String title;
  var quantity;
  final int grade;
  double totalprice;
  final double discountrate;
  final double rate;
  String unit;
  final String image;

  CartItem({
    @required this.id,
    @required this.pId,
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
    quantity = q;
    notifyListeners();
  }
  setUnit(u) {
    unit = u;
    notifyListeners();
  }
  settotalprice(ttp){
    totalprice = ttp;
  }
  getItemTotal(){
    if(unit == 'gm'){
      var temp = int.parse(quantity)/1000;
      totalprice = (totalprice * temp);
    }
    else{
      totalprice = (totalprice * double.parse(quantity));
    }
  }
  getweight(w) async {
    var dbprovider = DBProvider();
    //var dbclient = await dbprovider.database;

    var weightdata = await dbprovider.getweight(w);
    var unitdata = await dbprovider.getUnit(weightdata[0]['unitId']);

    await setquantity(weightdata[0]['name']);
    await setUnit(unitdata[0]['sname']);
    getItemTotal();



  }
}

class Cart with ChangeNotifier {
  Map<String,CartItem> _items = {};

  Map<String,CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }
  double _grandTotal =0;
double get grandTotal{
    calculteShippingCharge();
    _grandTotal = totalAmount + shippingcharge;
    notifyListeners();
    return _grandTotal;
}
double _shippingCharge = 0;
  double  get shippingcharge{
    calculteShippingCharge();
    return _shippingCharge;
  }
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key,cartItem) {
      total += cartItem.totalprice;
    });
    return total;
  }

calculateGrandTotal(){
  _grandTotal = totalAmount + shippingcharge;
}
calculteShippingCharge(){
  if(items.length>0) {
    (totalAmount < 200) ? _shippingCharge = 20 : _shippingCharge = 0;
  }
  else {
    _shippingCharge = 0;
  }
  notifyListeners();
}

  Future addItem({
    String productId,
    String image,
    double price,
    String title,
    int grade,
    int quantity,
  }
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
              id: existingCartItem.id,
              pId: existingCartItem.pId,
              grade: existingCartItem.grade,
              image : existingCartItem.image,
              title: existingCartItem.title,
              totalprice: existingCartItem.totalprice,
              quantity: quantity ,
            ),
      );
    }
    else if(_items.containsKey(productId+'_'+grade.toString())){
      _items.update(
        productId+'_'+grade.toString(),
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          pId: existingCartItem.pId,
          grade: existingCartItem.grade,
          image : existingCartItem.image,
          title: existingCartItem.title,
          totalprice: existingCartItem.totalprice,
          quantity: quantity ,
        ),
      );
    }
    else {
      _items.putIfAbsent(
        productId+'_'+grade.toString(),
        () => CartItem(
              id: DateTime.now().toString(),
              pId: productId,
              grade: grade,
              image: image,
              title: title,
              totalprice: price,
              quantity: quantity,

            ),
      );
    }

    calculteShippingCharge();
    //calculateGrandTotal();
    notifyListeners();
  }

  void removeItem(String productId) {
    print('pid $productId');
    print(_items);
    _items.remove(productId);
    print('items $_items');
    calculteShippingCharge();
    calculateGrandTotal();
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
    calculteShippingCharge();
   // calculateGrandTotal();
    notifyListeners();
  }

  void clear() {
    _items = {};
    calculteShippingCharge();
   // calculateGrandTotal();
    notifyListeners();
  }
}
