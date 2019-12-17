import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/app_drawer.dart';
//import 'confirm_order.dart';

class Checkout extends StatefulWidget {
  @override
  CheckoutState createState() => CheckoutState();
  static const routeName = '/checkout';
}
class CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f0),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text('Checkout',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
            fontSize: ScreenUtil.getInstance().setSp(60),
          )),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true
      ),
      body: SingleChildScrollView(
        child:Container(
          padding: const EdgeInsets.all(10.0),
          /*decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(204, 255, 255, 1).withOpacity(0.9),
                Color.fromRGBO(153,153,102,1).withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 6],
            ),
          ),*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 6,
              margin: EdgeInsets.only(top: 10),
              child: Container(
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
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Address Details',style: TextStyle(color: Color(0xFF609f38),fontWeight: FontWeight.bold,
                        //fontSize: 17,
                      fontSize: ScreenUtil.getInstance().setSp(45),
                    )),
                    Padding(padding: EdgeInsets.fromLTRB(0,10,0,10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Name:',style: TextStyle(fontWeight: FontWeight.bold,
                            //fontSize: 14
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                        Text('Johan singh',style: TextStyle(color: Colors.black,
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                      ],
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Address:',style: TextStyle(fontWeight: FontWeight.bold,
                            //fontSize: 14
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                        Text('linear-gradient(to bo   Ambala City',style: TextStyle(color: Colors.black,
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                      ],
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Area:',style: TextStyle(fontWeight: FontWeight.bold,
                            //fontSize: 14
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                        Text('linear-gradient( Ambala City',style: TextStyle(color: Colors.black,
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                      ],
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('City:',style: TextStyle(fontWeight: FontWeight.bold,
                            //fontSize: 14
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                        Text('Ambala City',style: TextStyle(color: Colors.black,
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                      ],
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Contact No.(s)',style: TextStyle(fontWeight: FontWeight.bold,
                            //fontSize: 14
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                        Text('6562365159',style: TextStyle(color: Colors.black,
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 6,
              margin: EdgeInsets.only(top: 10),
              child: Container(
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
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Order Details',style: TextStyle(color: Color(0xFF609f38),fontWeight: FontWeight.bold,
                        //fontSize: 17
                      fontSize: ScreenUtil.getInstance().setSp(45),
                    )),
                    Padding(padding: EdgeInsets.fromLTRB(0,10,0,10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Sub Total:',style: TextStyle(fontWeight: FontWeight.bold,
                            //fontSize: 14
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                        Text('Rs: 350.00',style: TextStyle(color: Colors.black,
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                      ],
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Handling Charges:',style: TextStyle(fontWeight: FontWeight.bold,
                            //fontSize: 14
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                        Text('Rs: 0.00',style: TextStyle(color: Colors.black,
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                      ],
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Grand Total:',style: TextStyle(fontWeight: FontWeight.bold,
                            //fontSize: 14
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                        Text('Rs: 350.00',style: TextStyle(color: Colors.black,
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 6,
              margin: EdgeInsets.only(top: 10),
              child: Container(
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
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Payment Method',style: TextStyle(color: Color(0xFF609f38),fontWeight: FontWeight.bold,
                        //fontSize: 17
                      fontSize: ScreenUtil.getInstance().setSp(45),
                    )),
                    Padding(padding: EdgeInsets.fromLTRB(0,10,0,10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Cash on Delivery:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                            //fontSize: 16
                          fontSize: ScreenUtil.getInstance().setSp(40),
                        )),
                        Icon(Icons.check_circle,
                          //color: Color(0xFF609f38),
                          color: Color(0xFF609f38),
                        size: 18,
                        ),
                      ],
                    ),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),
                          child: Text('Handling Charges:',style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Text('Rs: 0.00'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0,10,0,0),
                          child: Text('Grand Total:',style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Text('Rs: 350.00'),
                      ],
                    ),*/
                    /*ListTile(contentPadding: EdgeInsets.all(0),
                      title: Text('Grand Total:'),
                      trailing: Text('Rs: 350.00'),
                      dense: true,
                    ),*/
                  ],
                ),
              ),
            ),
            Card(
              elevation: 6,
              margin: EdgeInsets.only(top: 10),
              child: Container(
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
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MaterialButton(
                      elevation: 9,
                      //minWidth: 180.0,
                      colorBrightness: Brightness.dark,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.white,
                          width: 0.3,
                          style: BorderStyle.solid
                      ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:Container(
                        child: Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.fromLTRB(5,10,6,10),
                              child: Icon(Icons.shopping_cart,size:18),
                            ),
                            Text("Go To Cart",style: new TextStyle(
                              //fontSize:13,
                              fontSize: ScreenUtil.getInstance().setSp(40),
                              color: Colors.white,
                              fontFamily: 'Montserrat-Regular',
                            ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                       // Navigator.of(context).pushNamed(ConfirmOrder.routeName);
                      },
                    ),
                    MaterialButton(
                      elevation: 9,
                      //minWidth: 180.0,
                      //height: 30.0,
                      colorBrightness: Brightness.dark,
                      color: new Color(0xFF609f38),
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.white,
                          width: 0.3,
                          style: BorderStyle.solid
                      ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:Container(
                        child: Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.fromLTRB(5,10,6,10),
                              child: Icon(Icons.check_circle,size:18),
                            ),
                            Text("Place Order",style: new TextStyle(
                              //fontSize:14,
                              fontSize: ScreenUtil.getInstance().setSp(40),
                              color: Colors.white,
                              fontFamily: 'Montserrat-Regular',
                            ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                       // Navigator.of(context).pushNamed(ConfirmOrder.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
