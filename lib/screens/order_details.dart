import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:onlinemandi/providers/database.dart';
import 'package:onlinemandi/providers/orders.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_drawer.dart';
import 'edit_orders.dart';
import 'my_account.dart';
//import 'confirm_order.dart';
//import 'edit_orders.dart';

class OrderDetails extends StatefulWidget {
  var orderid;
  var title;
  OrderDetails({orderid, title}){
    this.orderid = orderid;
    this.title = title;
  }

  @override
  OrderDetailsState createState() => OrderDetailsState();
  static const routeName = '/orderdetails';
}
class OrderDetailsState extends State<OrderDetails> {
  var weight;
  var loadedweight = false;
  var orderDetails;
  var unit;
  OrderDetailsState({order}){
    this.orderDetails = order;

  }

  @override
  Widget build(BuildContext context) {
    var ordersData = Provider.of<Orders>(context);
    var orders = ordersData.findOrderbyid(widget.orderid);
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('Order Details',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(60))),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true
      ),
      body: Container(
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
                      Text('Order Date: ${orders.date}',style: TextStyle(color: Color(0xFF609f38),fontWeight: FontWeight.bold,
                        //fontSize: 17
                        fontSize: ScreenUtil.getInstance().setSp(50),
                      )),
                      Padding(padding: EdgeInsets.fromLTRB(0,10,0,10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Order Number: ',style: TextStyle(fontWeight: FontWeight.bold,
                            //fontSize: 14
                            fontSize: ScreenUtil.getInstance().setSp(40),
                          )),
                          Text('${orders.id}',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(40))),
                        ],
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Number of Items:',style: TextStyle(fontWeight: FontWeight.bold,
                            //fontSize: 14
                            fontSize: ScreenUtil.getInstance().setSp(40),
                          )),
                          Text('${orders.products.length}',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(40))),
                        ],
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Total Amount:',style: TextStyle(fontWeight: FontWeight.bold,
                            //fontSize: 14
                            fontSize: ScreenUtil.getInstance().setSp(40),
                          )),
                          Text('${orders.orderAmount}',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(40))),
                        ],
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Shipping Charges:',style: TextStyle(fontWeight: FontWeight.bold,
                            //fontSize: 14
                            fontSize: ScreenUtil.getInstance().setSp(40),
                          )),
                          Text('${orders.shippingcharge}',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(40))),
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
                          Text('${orders.grandtotal}',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(40))),
                        ],
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //Text('City:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color:Colors.white)),
                          widget.title == 'Active Orders' ?  MaterialButton(
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
                                    child: Icon(Icons.cancel,size: 20),
                                  ),
                                  Text("Cancel Order",style: new TextStyle(
                                    //fontSize:13,
                                    fontSize: ScreenUtil.getInstance().setSp(40),
                                    color: Colors.white,
                                    fontFamily: 'Montserrat-Regular',
                                  ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () => _displayDialog(context,orders.orderAmount),
                          ) : Text(''),
                          widget.title == 'Active Orders' ?  MaterialButton(
                            elevation: 9,
                            //minWidth: 180.0,
                            colorBrightness: Brightness.dark,
                            color: Colors.green,
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
                                    child: Icon(Icons.edit,size: 20),
                                  ),
                                  Text("Edit Order",style: new TextStyle(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditOrder(orderid: widget.orderid),
                                ),
                              );
                            },
                          ) : Text(''),
                        ],
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: _displayitems(orders)
              )

            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget _displayitems(orders){
   // final ordersData = Provider.of<Orders>(context,listen: false);
    // orders = ordersData.orders.firstWhere((order) =>order.id == widget.orderid);
    return IconTheme(
        data: new IconThemeData(color: Colors.green),
        child: ListView.builder(
            itemCount: orders.products.length,
            itemBuilder: (BuildContext context, int index){

              return Card(
                elevation:6,
                //color: Colors.red,
                margin: EdgeInsets.only(top: 12),
                child: Container(
                  //height: 120,
                  //padding: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: ListTile(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      leading: Container(
                        //margin: const EdgeInsets.only(left:0 ,right:10),
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.all(Radius.circular(50.0)),

                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Image.network(
                            GlobalConfiguration().getString("assetsURL")+orders.products[index].image,
                            height: 100,
                            width: 100,
                          ),

                        ),
                      ),

                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('${orders.products[index].title}',style: TextStyle(
                            //fontSize: 14,
                              fontSize: ScreenUtil.getInstance().setSp(45),
                              color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Row(
                            children: <Widget>[
                              Text(
                                'Quality: ',style: TextStyle(color: Color(0xFF609f38),
                                  //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                  fontWeight: FontWeight.bold),
                              ),
                              Text( '${orders.products[index].grade == 0 ? 'Premium' : 'Regular'}',
                                style: TextStyle(
                                  color: Colors.black,
                                  //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Row(
                            children: <Widget>[
                              Text('Quantity: ',style: TextStyle(color: Color(0xFF609f38),
                                  //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                  fontWeight: FontWeight.bold),
                              ),
                              Text('${ orders.products[index].quantity} ${orders.products[index].unit}',
                                style: TextStyle(
                                  color: Colors.black,
                                  //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Row(
                            children: <Widget>[
                              Text('Applied Rate: ',style: TextStyle(color: Color(0xFF609f38),
                                  //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                  fontWeight: FontWeight.bold),
                              ),
                              Text('Rs ${orders.products[index].totalprice}/${orders.products[index].unit}',
                                style: TextStyle(
                                  color: Colors.black,
                                  // fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Row(
                            children: <Widget>[
                              Text('Total Price : ',style: TextStyle(color: Color(0xFF609f38),
                                  //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                  fontWeight: FontWeight.bold),
                              ),
                              Text('Rs ${orders.products[index].totalprice}',
                                style: TextStyle(
                                  color: Colors.black,
                                  //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          //Text('Quantity: 2kg',style: TextStyle(fontSize: 13,color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        )
    );
  }
  _displayDialog(BuildContext context,id) async {
    final ordersData = Provider.of<Orders>(context);
    final orders = ordersData.orders.firstWhere((order) =>order.id == widget.orderid);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Confirm Cancel order",style: TextStyle(
              //fontSize:18,
                fontSize: ScreenUtil.getInstance().setSp(60),
                color: Colors.black,fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              //width: MediaQuery.of(context).size.width * 1.1,
              //height: MediaQuery.of(context).size.height * 0.3,
              child: ListBody(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Are you sure to ',style: TextStyle(color: Colors.black,
                          //fontSize: 14
                          fontSize: ScreenUtil.getInstance().setSp(60),
                        ),
                        ),
                        TextSpan(
                          text: 'cancel order?',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            //fontSize: 15,
                            fontSize: ScreenUtil.getInstance().setSp(60),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    elevation: 9,
                    colorBrightness: Brightness.dark,
                    color: Colors.green,
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
                          /*Padding(padding: EdgeInsets.fromLTRB(5,9,6,9),
                       // child: Icon(Icons.cancel,color: Colors.white),
                      ),*/
                          Text("Cancel",style: new TextStyle(
                            //fontSize:12,
                            fontSize: ScreenUtil.getInstance().setSp(40),
                            color: Colors.white,
                            fontFamily: 'Montserrat-Regular',
                          ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  MaterialButton(
                    elevation: 9,
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
                          /*Padding(padding: EdgeInsets.fromLTRB(5,9,6,9),
                       // child: Icon(Icons.cancel,color: Colors.white),
                      ),*/
                          Text("OK",style: new TextStyle(
                            //fontSize:12,
                            fontSize: ScreenUtil.getInstance().setSp(40),
                            color: Colors.white,
                            fontFamily: 'Montserrat-Regular',
                          ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: (){cancelOrder(orders.id);},
                  ),
                ],
              ),
            ],
          );
        }
    );
  }
  cancelOrder(orderId) async {
    var pref = await SharedPreferences.getInstance();
    var userdata = json.decode(pref.get('userData'));
    var order = GetOrder(userdata['token'],userdata['userId']);
    order.cancelOrder(orderId).then((data){
      Fluttertoast.showToast(
        msg: data['msg'],
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIos: 1,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
      );
    }).then((data){
      Navigator.of(context)
          .pushReplacementNamed(MyAccount.routeName);

    });


  }
}
