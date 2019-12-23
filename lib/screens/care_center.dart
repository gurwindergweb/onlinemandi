import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    ScreenUtil.instance = ScreenUtil()..init(context);
    //getuserdetail();
    print('userdata');
    print(userData);
    return Scaffold(
      appBar: AppBar(
          title: Text('OnlineMandi Care',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(60))),
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
        child: _care(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget _care () {
    return IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: ListView(
        children: <Widget>[
          Card(
            elevation: 6,
            child: ListTile(
              title: Text('${userData['city']} Office',style: TextStyle(color: Color(0xFF609f38),fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(50))),
              subtitle: Padding(
                padding: EdgeInsets.fromLTRB(0,5,0,5),
                child: Text('Customer Support Numbers:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: ScreenUtil.getInstance().setSp(45))),
              ),
              trailing: Padding(
                padding: EdgeInsets.all(1),
                child: Column(
                  children: <Widget>[
                    Text(userData['sellerContact1'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(45))),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(userData['sellerContact2'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(45))),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 6,
            child: ListTile(
              title: Text('Head Office',style: TextStyle(color: Color(0xFF609f38),fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(50))),
              subtitle:  Padding(
                padding: EdgeInsets.fromLTRB(0,5,0,5),
                child: Text('Customer Support Numbers:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: ScreenUtil.getInstance().setSp(45))),
              ),
              trailing: Padding(
                padding: EdgeInsets.all(1),
                child: Column(
                  children: <Widget>[
                    Text('9781349506',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(45))),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text('9478109281',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(45))),
                  ],
                ),
              ),
              //leading: ,
            ),
          ),
        ],
      ),
    );
  }
}

