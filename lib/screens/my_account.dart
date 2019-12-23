import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlinemandi/providers/auth.dart';
import 'package:onlinemandi/providers/cart.dart';
import 'package:onlinemandi/providers/orders.dart';
import 'package:onlinemandi/screens/user_detail.dart';
import 'package:onlinemandi/widgets/badge.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_drawer.dart';
import 'care_center.dart';
import 'cart_screen.dart';
import 'my_order.dart';
import 'change_password.dart';
import 'my_wallet.dart';
import 'orders_screen.dart';

class MyAccount extends StatefulWidget {
  @override
  MyAccountState createState() => MyAccountState();
  static const routeName = '/myaccount';
}

class MyAccountState extends State<MyAccount> {
var auth = Auth();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('My Account',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(60))),
          //title: Text('My Account',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,

          actions: <Widget>[
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                child: Icon(Icons.home),
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
            ),
          ],

      ),
      drawer: AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person,color: Color(0xFF609f38)),
            trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
            title: Text('Personal Details',style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(45))),
            onTap: () {
              Navigator.of(context).pushNamed(UserDetail.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone_in_talk,color: Color(0xFF609f38)),
            trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
            title: Text('OnlineMandi Support',style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(45))),
            onTap: () {
              Navigator.of(context).pushNamed(CareCenter.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_basket,color: Color(0xFF609f38)),
            trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
            title: Text('My Orders',style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(45))),
            onTap: getorders,
          ),
          Divider(),
          /*ListTile(
              leading: Icon(Icons.account_balance_wallet,color: Color(0xFF609f38)),
              trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
              title: Text('My Wallet',style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40))),
              onTap: () {
                Navigator.of(context).pushNamed(MyWallet.routeName);
              },
            ),*/
          ListTile(
            leading: Icon(Icons.phonelink_lock,color: Color(0xFF609f38)),
            trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
            title: Text('Change Password',style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(45))),
            onTap: () {
              Navigator.of(context).pushNamed(ChangePassword.routeName);
            },
          ),
          Divider(),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
getorders() async {
  var  prefs = await SharedPreferences.getInstance();
  var resp =  prefs.get('userData');
  var user = json.decode(resp);

  var orders = GetOrder(user['token'],user['userId']);
  await orders.getOrders().then((orders){
   Navigator.push(
     context,
     MaterialPageRoute(
       builder: (context) => MyOrder(order: orders),
     ),
   );
  });

}

}
