import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/app_drawer.dart';

class Thankyou extends StatefulWidget {
  int orderId;
  String sellerContact;
  Thankyou({orderId,sellerContact}){
    this.orderId = orderId;
    this.sellerContact = sellerContact;
    print('thankyou page value');
    print(orderId);
    print(sellerContact);
  }
  @override
  ThankyouState createState() => ThankyouState(orderId,sellerContact);
  static const routeName = '/confirmorder';
}

class ThankyouState extends State<Thankyou> {
  int orderId;
  String sellerContact;
  ThankyouState(this.orderId,this.sellerContact){
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Placed Order',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(60),)),
        backgroundColor: Color(0xFF609f38),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: InkWell(
              child: Icon(Icons.home),
              onTap: (){
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(255, 255, 255, 1).withOpacity(0.5),
                Color.fromRGBO (153, 255, 153, 1).withOpacity(0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 6],
            ),
          ),
          padding: const EdgeInsets.only(top: 2),
          child: _contentcol(orderId,sellerContact),
      ),
    );
  }

}
Widget _contentcol (orderId,sellerContact) {
  return IconTheme(
    data: new IconThemeData(color: Colors.blue),
    child: ListView(
      children: <Widget>[
        Image.asset(
          'images/hjo13.gif',
          /*width: 90,
          height: 90,*/
          fit: BoxFit.cover,
        ),
        Card(
          elevation: 0,
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(10)),
                Padding(padding: EdgeInsets.all(8)),
                Animator<double>(
                    tween: Tween<double>(begin: 0.8, end: 2.0),
                    //repeats: 0,
                    curve : Curves.fastOutSlowIn,
                    cycles: 0,
                    duration: Duration(seconds: 2),
                    builder: (anim) => Transform.scale(scale: anim.value,
                      child: Text('Thank you*',style: TextStyle(color: Colors.red,fontSize: ScreenUtil.getInstance().setSp(50),fontWeight: FontWeight.bold)),
                    )
                ),
                Padding(padding: EdgeInsets.all(10)),
                //Text('Your have Successfully placed your order. Your order number is 1567',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.normal)),
                Column(
                  children: <Widget>[
                    Text("You have Successfully placed your order. Your order number is (${orderId})",style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(50),fontWeight: FontWeight.normal),),
                    /*Text('${orderId}',
                      style: TextStyle(
                        color: Color(0xFF609f38),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil.getInstance().setSp(50),
                      ),
                    ),*/
                  ],
                ),
                Padding(padding: EdgeInsets.all(8)),
                //Text('Your order will be delivered at your registered address tomorrw before 1PM.',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.normal)),
               Column(
                 children: <Widget>[
                   Text("Your order will be delivered at your registered address tomorrow before '1PM.' ",style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(50),fontWeight: FontWeight.normal),),
                 ],
               ),
               /* RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Your order will be delivered at your registered address tomorrow before ',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(50),fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: '1PM.',
                        style: TextStyle(
                          color: Color(0xFF609f38),
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil.getInstance().setSp(50),
                        ),
                      ),
                    ],
                  ),
                ),*/
                Padding(padding: EdgeInsets.all(8)),
                //Text('For any query. contact us at  9464772255, 9478109281',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.normal)),
                Column(
                  children: <Widget>[
                    Text("For any query. contact us at '${sellerContact}'",style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(50),fontWeight: FontWeight.normal),),
                    /*Text('${sellerContact}',
                      style: TextStyle(
                        color: Color(0xFF609f38),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil.getInstance().setSp(50),
                      ),
                    ),*/
                  ],
                ),
                /*RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'For any query. contact us at ',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(50),fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: '${sellerContact}',
                        style: TextStyle(
                          color: Color(0xFF609f38),
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil.getInstance().setSp(50),
                        ),
                      ),
                    ],
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset(
                    'images/online-logo1.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child:Text('Since @2016 onlinemandi.com',style: TextStyle(
                    //color: Color(0xFF609f38),
                    color: Color(0xFF609f38),
                    fontWeight: FontWeight.normal,
                    fontSize: ScreenUtil.getInstance().setSp(45),
                  )),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}