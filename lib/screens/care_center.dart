import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_drawer.dart';

class CareCenter extends StatefulWidget {
  @override
  CareCenterState createState() => CareCenterState();
  static const routeName = '/carecenter';
}
class CareCenterState extends State<CareCenter> {
  var resp;
  var userData;
  var prefs;
  @override
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
    //getuserdetail();
    print('userdata');
    print(userData);
    return Scaffold(
      appBar: AppBar(
          title: Text('OnlineMandi Care',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 12,
              child: ListTile(
                title: Text('${userData['city']} Office',style: TextStyle(color: Color(0xFF609f38),fontWeight: FontWeight.bold,fontSize: 17)),
                subtitle: Padding(
                  padding: EdgeInsets.fromLTRB(0,10,0,5),
                  child: Text('Customer Support Numbers:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14,)),
                ),
                trailing: Padding(
                  padding: EdgeInsets.all(1),
                  child: Column(
                    children: <Widget>[
                      Text(userData['sellerContact1'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(userData['sellerContact2'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 12,
              child: ListTile(
                title: Text('Head Office',style: TextStyle(color: Color(0xFF609f38),fontWeight: FontWeight.bold,fontSize: 17)),
                subtitle:  Padding(
                  padding: EdgeInsets.fromLTRB(0,8,0,5),
                  child: Text('Customer Support Numbers:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14,)),
                ),
                trailing: Padding(
                    padding: EdgeInsets.all(1),
                    child: Column(
                      children: <Widget>[
                        Text('9781349506',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                        Padding(padding: EdgeInsets.all(5)),
                        Text('9478109281',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                      ],
                    ),
                  ),
                  //leading: ,
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}

