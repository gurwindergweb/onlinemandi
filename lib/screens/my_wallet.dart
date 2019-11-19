import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class MyWallet extends StatefulWidget {
  @override
  MyWalletState createState() => MyWalletState();
  static const routeName = '/mywallet';
}
class MyWalletState extends State<MyWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Wallet',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(204, 255, 255, 1).withOpacity(0.9),
              Color.fromRGBO(153,153,102,1).withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 6],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/online-logo.png',
              width: 90,
              height: 90,
            ),
            Padding(padding: EdgeInsets.all(10),),
            Text(
              'OnlineMandi',
              style: TextStyle(
                //color: Color(0xff006600),
                color:Color(0xFF609f38),
                fontSize: 38,
                fontFamily: 'Anton',
                fontWeight: FontWeight.normal,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                 Card(
                   color: Colors.white,
                   //elevation: 12,
                   child: Container(
                    padding: EdgeInsets.all(20),
                     child: Column(
                       children: <Widget>[
                         Padding(
                          padding: EdgeInsets.fromLTRB(0,5,0,10),
                          child:Text('Wallet Status',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color(0xFF609f38))),
                         ),
                         Text('Panding',style: TextStyle(color: Colors.red)),
                       ],
                     ),
                   ),
                 ),
                 Card(
                    color: Colors.white,
                    //elevation: 12,
                     child: Container(
                       padding: EdgeInsets.all(20),
                       child: Column(
                         children: <Widget>[
                           Padding(
                             padding: EdgeInsets.fromLTRB(0,5,0,10),
                             child: Text('Wallet Balance',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color(0xFF609f38))),
                           ),
                           Text('Rs: 240.00'),
                         ],
                       ),
                     ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
