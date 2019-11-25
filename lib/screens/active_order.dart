import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'order_details.dart';

class ActiveOrder extends StatefulWidget {
  var activeorders;
  ActiveOrder({activeorder}){
    this.activeorders = activeorder;
  }
  @override
  ActiveOrderState createState() => ActiveOrderState(this.activeorders);
  static const routeName = '/activeorder';
}
class ActiveOrderState extends State<ActiveOrder> {
  var orders;
  ActiveOrderState(activeorder){
    this.orders = activeorder;
    print(this.orders['o'][1]);
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('Active Orders',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(60))),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true
      ),
      body: new ListView.builder
        (
          itemCount: this.orders.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Container(
              child:Container(
                padding: const EdgeInsets.all(10.0),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      elevation: 6,
                      margin: EdgeInsets.only(top: 10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Order Date: ${this.orders['o'][index]['date']}',style: TextStyle(color: Color(0xFF609f38),fontWeight: FontWeight.bold,
                              //fontSize: 17
                              fontSize: ScreenUtil.getInstance().setSp(50),
                            )),
                            Padding(padding: EdgeInsets.fromLTRB(0,10,0,10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Order Number: ',style: TextStyle(fontWeight: FontWeight.bold,
                                  //fontSize: 14
                                  fontSize: ScreenUtil.getInstance().setSp(42),
                                )),
                                Text('${this.orders['o'][index]['id']}',style: TextStyle(color: Colors.black,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                )),
                              ],
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Number of Items:',style: TextStyle(fontWeight: FontWeight.bold,
                                  //fontSize: 14
                                  fontSize: ScreenUtil.getInstance().setSp(42),
                                )),
                                Text('${this.orders['o'][index]['ic']}',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(40))),
                              ],
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Order Total:',style: TextStyle(fontWeight: FontWeight.bold,
                                  //fontSize: 14
                                  fontSize: ScreenUtil.getInstance().setSp(42),
                                )),
                                Text('${this.orders['o'][index]['gt']}',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(40))),
                              ],
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('City:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color:Colors.white)),
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
                                          child: Icon(Icons.remove_red_eye,size: 20),
                                        ),
                                        Text("View Details",style: new TextStyle(
                                          //fontSize:13,
                                          fontSize: ScreenUtil.getInstance().setSp(38),
                                          color: Colors.white,
                                          fontFamily: 'Montserrat-Regular',
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderDetails(orderdetail: this.orders['o'][index]),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            );
          }
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
