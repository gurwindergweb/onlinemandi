import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/app_drawer.dart';

class MantinesMode extends StatefulWidget {
  @override
  MantinesModeState createState() => MantinesModeState();
  static const routeName = '/mantinesmode';
}

class MantinesModeState extends State<MantinesMode> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
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
               Container(
                 child: Stack(
                   children: <Widget>[
                     Image.asset(
                       'images/abs.png',
                     ),
                     Positioned(
                       top: 60,
                       left: 140,
                       child:  Center(
                         // padding: const EdgeInsets.all(20.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Padding(
                               padding: EdgeInsets.all(0),
                               child: Image.asset(
                                 'images/online-logo1.png',
                                 width: 80,
                                 height: 80,
                                 fit: BoxFit.cover,
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               Padding(
                 padding: EdgeInsets.all(0),
                 child:Text('We will be right back soon....',style: TextStyle(
                   //color: Color(0xFF609f38),
                   color: Color(0xFF609f38),
                   fontWeight: FontWeight.normal, fontSize: ScreenUtil.getInstance().setSp(50),
                 )),
               ),
             ],
           ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
