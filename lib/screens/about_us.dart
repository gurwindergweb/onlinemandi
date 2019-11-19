import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class About extends StatefulWidget {
  @override
  AboutState createState() => AboutState();
  static const routeName = '/about';
}

class AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF609f38),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Comapany Name',style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            )),
            Padding(
              padding: EdgeInsets.all(5),
              child:Text('Maspgonn Marketing LLP.',style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15,
              )),
            ),
            Padding(
              padding: EdgeInsets.all(5),
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
