import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class TermConditions extends StatefulWidget {
  @override
  TermConditionsState createState() => TermConditionsState();
  static const routeName = '/TermConditions';
}

class TermConditionsState extends State<TermConditions> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Terms & Conditions',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true
      ),
      body: Center(
       // padding: const EdgeInsets.all(20.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25),
              child: Image.asset(
                'images/online-logo1.png',
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child:Text('@2016 onlinemandi.com',style: TextStyle(
                color: Color(0xFF609f38),
                fontWeight: FontWeight.normal,
                fontSize: 15,
              )),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
