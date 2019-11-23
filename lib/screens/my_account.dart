import 'package:flutter/material.dart';
import 'package:onlinemandi/screens/user_detail.dart';
import '../widgets/app_drawer.dart';
import 'care_center.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My Account',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          //title: Text('My Account',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,

          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.shopping_cart),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.home),
            ),
          ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person,color: Color(0xFF609f38)),
              trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
              title: Text('Personal Details'),
              onTap: () {
                Navigator.of(context).pushNamed(UserDetail.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone_in_talk,color: Color(0xFF609f38)),
              trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
              title: Text('OnlineMandi Support'),
              onTap: () {
                Navigator.of(context).pushNamed(CareCenter.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shopping_basket,color: Color(0xFF609f38)),
              trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
              title: Text('My Orders'),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(MyOrder.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_balance_wallet,color: Color(0xFF609f38)),
              trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
              title: Text('My Wallet'),
              onTap: () {
                Navigator.of(context).pushNamed(MyWallet.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phonelink_lock,color: Color(0xFF609f38)),
              trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
              title: Text('Change Password'),
              onTap: () {
                Navigator.of(context).pushNamed(ChangePassword.routeName);
              },
            ),
            Divider(),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
