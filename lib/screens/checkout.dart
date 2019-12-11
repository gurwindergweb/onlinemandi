import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlinemandi/providers/cart.dart';
import 'package:onlinemandi/providers/orders.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_drawer.dart';
import 'cart_screen.dart';

class Checkout extends StatefulWidget {
  @override
  CheckoutState createState() => CheckoutState();
  static const routeName = '/checkout';
}
class CheckoutState extends State<Checkout> {
  var _isLoading = false;

  SharedPreferences prefs;
  var resp;
  var userData;
  void initState() {
    getuserdetail();
  }
  getuserdetail() async {
    prefs = await SharedPreferences.getInstance();
    resp = prefs.get('userData');
    setState(() {
      userData = json.decode(resp);
    });
  }
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    print('userData');
    print(userData);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('Checkout',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Address Details',
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(50),
                  fontWeight: FontWeight.bold,
                )
                ,
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
                        Text('Name',
                          style: TextStyle(
                           fontSize: ScreenUtil.instance.setSp(40),
                           fontWeight: FontWeight.bold,
                          ),
                       ),
                       Text('${userData['username']}',
                        style: TextStyle(
                          fontSize: ScreenUtil.instance.setSp(40),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Address',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${userData['location']}',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Area',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${userData['city']}',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('City',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${userData['city']}',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Contact',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${userData['contact1']}, ${userData['contact2']}',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),),
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Order Details',
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(50),
                  fontWeight: FontWeight.bold,
                )
                ,
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
                        Text('Sub Total',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Rs ${cart.totalAmount}',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Shipping Charges',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Rs ${cart.shippingcharge}',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Grand Total',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Rs ${cart.grandTotal}',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),),
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Payment Method',
                style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(50),
                  fontWeight: FontWeight.bold,
                )
                ,
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
                        Text('Cash on delivery',
                          style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.check,
                          size: 20,
                        ),

                      ],
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
          MaterialButton(
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
          child: _isLoading ? CircularProgressIndicator() : Text('Go to Cart',style: TextStyle(color: Colors.white,fontSize: 12)),
          onPressed:  () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
          },
          textColor: Theme.of(context).primaryColor,
        ),
        MaterialButton(
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
          child: _isLoading ? CircularProgressIndicator() : Text('Place Order',style: TextStyle(color: Colors.white,fontSize: 12)),
          onPressed:  (cart.totalAmount <= 0 || _isLoading)
    ? null
        : () async {
    setState(() {
    _isLoading = true;
    });
    await Provider.of<Orders>(context, listen: false).addOrder(
    cart.items.values.toList(),
    cart.totalAmount,
    );
    setState(() {
    _isLoading = false;
    });
    cart.clear();
    },    textColor: Theme.of(context).primaryColor,
        ),

      ],
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
