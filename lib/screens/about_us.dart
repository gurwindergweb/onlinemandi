import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/app_drawer.dart';

class About extends StatefulWidget {
  @override
  AboutState createState() => AboutState();
  static const routeName = '/about';
}

class AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(60))),
        backgroundColor: Color(0xFF609f38),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true
      ),
      body: Center(
       child: SingleChildScrollView(
         child: Center(
           // padding: const EdgeInsets.all(20.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text('Comapany Name',style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.bold,
                   fontSize: ScreenUtil.getInstance().setSp(50)
               )),
               Padding(
                 padding: EdgeInsets.all(5),
                 child:Text('Maspgonn Marketing LLP.',style: TextStyle(
                     color: Colors.black,
                     fontWeight: FontWeight.normal,
                     fontSize: ScreenUtil.getInstance().setSp(45)
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
                   fontWeight: FontWeight.normal, fontSize: ScreenUtil.getInstance().setSp(50),
                 )),
               ),
             ],
           ),
         ),
       ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
