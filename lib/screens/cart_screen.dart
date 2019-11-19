import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f0),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Your Cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF609f38),
        centerTitle: true,
        //centerTitle: true,
        actions: <Widget>[
          Padding(padding: EdgeInsets.all(10),
          child: Icon(Icons.delete_sweep, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            child: Expanded(
              child:  ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title,
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Sub Total:',
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey[500]),
                      ),
                      Text(
                        'Rs: 10.00',
                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(6)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Shipping Charges:',
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey[500]),
                      ),
                      Text(
                        'Rs: 20.00',
                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color:Color(0xFF609f38)),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(6)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total:',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                      //Spacer(),
                      Chip(
                        label: Text(
                          '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            // color: Theme.of(context).primaryTextTheme.title.color,
                            color: Colors.white,
                            //fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        backgroundColor:  Color(0xFF609f38),
                      ),
                      OrderButton(cart: cart)
                    ],
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 8,
      //minWidth: 100.0,
      //height: 40.0,
      colorBrightness: Brightness.dark,
      color: new Color(0xFF609f38),
      shape: RoundedRectangleBorder(side: BorderSide(
          color: Colors.white,
          width: 1.3,
          style: BorderStyle.solid
      ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW *',style: TextStyle(color: Colors.white,fontSize: 12)),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
