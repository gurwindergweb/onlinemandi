import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
  static const routeName = '/homepage';
}

class HomePageState extends State<HomePage> {

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
      body: Container(
        //color: Colors.black87,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              //Color.fromRGBO (000,000, 000, 5).withOpacity(0.9),
              Color.fromRGBO (235,241, 214, 1).withOpacity(0.9),
              Color.fromRGBO(255, 255, 255, 1).withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 5],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                  //height: 345.0,
                  //width: MediaQuery.of(context).size.width,
                  child: Carousel(
                    boxFit: BoxFit.fitWidth,
                    images: [
                      ExactAssetImage("images/slide4.jpg"),
                      ExactAssetImage("images/slider_four.jpg"),
                      ExactAssetImage("images/4banner.png"),
                      ExactAssetImage("images/bgs.jpg"),
                      ExactAssetImage("images/3banner.png"),
                      ExactAssetImage("images/BANNER.jpg"),
                      ExactAssetImage("images/2banner.jpg"),
                    ],
                    autoplay: true,
                    animationCurve: Curves.easeInOut,
                    animationDuration: Duration(milliseconds: 2500),
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.lightGreenAccent,
                    indicatorBgPadding: 12.0,
                    borderRadius: false,
                    overlayShadow: true,
                    overlayShadowColors: Colors.black,
                    overlayShadowSize: 0.8,
                  )
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0,5,0,5),
                    margin: EdgeInsets.fromLTRB(0,0,0,10),
                    height: 50,
                    //color: Color(0xffebf1d6),
                    child: Center(
                      child: Text('SHOP BY CATEGORY',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'Lato')),
                    ),
                    decoration: new BoxDecoration(
                      //color: Color(0xffebf1d6),//new Color.fromRGBO(255, 0, 0, 0.0),
                      color: Color(0xFF609f38),
                      border: Border(
                      bottom: BorderSide( //                   <--- left side
                        color: Color(0xffebf1d6),
                        width: 3.0,
                      ),
                    ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          //color: Color(0xffEFFFDF),
                        ),
                        child: Image.asset('images/fruitapp.png',fit:BoxFit.contain),
                      ),
                      Positioned(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xffebf1d6),
                                        width: 3.0,
                                      ),
                                    ),
                                  ),
                                  height: 100,
                                  width: 150,
                                  child: Card(
                                    margin: EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    elevation: 19,
                                    child: Container(
                                      //padding: EdgeInsets.all(18),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset('images/images.jpg',height: 60,width: 60,),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 37,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF609f38),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                bottomRight: Radius.circular(40),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text('FRUITS ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,fontStyle: FontStyle.normal,fontFamily: 'Lato',color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide( //                   <--- left side
                                        color: Color(0xffebf1d6),
                                        width: 3.0,
                                      ),
                                    ),
                                  ),
                                  height: 100,
                                  width: 150,
                                  child: Card(
                                    margin: EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                    elevation: 12,
                                    child: Container(
                                      //padding: EdgeInsets.all(15),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset('images/basket.png',height: 60,width: 60,fit: BoxFit.cover,),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 37,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF609f38),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                bottomRight: Radius.circular(40),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text('VEGETABLES',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,fontStyle: FontStyle.normal,fontFamily: 'Lato',color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  /*Container(
                    width: MediaQuery.of(context).size.width,
                    child:
                    Image.asset('images/Fruit1.png',height: 60,width: 60,fit: BoxFit.cover,
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child:
              Image.asset('images/Fruit1.png',height: 60,width: 60,fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
