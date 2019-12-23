import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/app_drawer.dart';

class MantainanceMode extends StatefulWidget {
  @override
  MantainanceModeState createState() => MantainanceModeState();
  static const routeName = '/mantainancesmode';
}

class MantainanceModeState extends State<MantainanceMode> {

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.instance = ScreenUtil()..init(context);
    return MaterialApp(
      home: Scaffold(
        /*appBar: AppBar(
          title: Text('Mantines Mode',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(60))),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true
      ),*/
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  // padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Image.asset(
                          'images/online-logo.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Text('We will be right back soon....',style: TextStyle(
                    //color: Color(0xFF609f38),
                    color: Color(0xFF609f38),
                    fontWeight: FontWeight.normal, fontSize: 22,
                  )),
                ),
              ],
            ),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

}
