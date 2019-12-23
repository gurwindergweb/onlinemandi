import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:onlinemandi/providers/cart.dart';
import 'package:onlinemandi/providers/database.dart';
import 'package:onlinemandi/providers/orderitem.dart';
import 'package:onlinemandi/providers/orders.dart';
import 'package:onlinemandi/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_drawer.dart';
import 'my_order.dart';
//import 'confirm_order.dart';

class EditOrder extends StatefulWidget {
  var orderid;
  var weight;
  var dbprovider = DBProvider();
  EditOrder({orderid}){
    this.orderid = orderid;
  }

  @override
  EditOrderState createState() => EditOrderState(orderid:orderid);
  static const routeName = '/editorder';
}
class EditOrderState extends State<EditOrder> {
  var weight;
  var orderid ;
  var orders;
  var ordersData;
  var unit;

  Cart cart;

  Products products;

  bool loading = false;
  EditOrderState({orderid}){
    this.orderid = orderid;
  }
  @override
  Widget build(BuildContext context) {
    ordersData = Provider.of<Orders>(context);
    orders = ordersData.findOrderbyid(widget.orderid);
     products = Provider.of<Products>(context);
     cart = Provider.of<Cart>(context);
    var order = orders;

    Widget _showitemlist(){
      ScreenUtil.instance = ScreenUtil()..init(context);
      return IconTheme(
          data: new IconThemeData(color: Colors.green),
          child: ListView.builder(
              itemCount: orders.products.length,
              itemBuilder: (BuildContext context,int index) {
                var prod = products.findById(orders.products[index].id);
                print(prod.weights);
                var pweights = prod.weights;
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.35,
                  child: Card(
                    elevation: 6,
                    margin: EdgeInsets.fromLTRB(0,5,0,5),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,15,0,18),
                      //color: Colors.white,
                      child: ListTile(
                        leading: Container(
                          margin: const EdgeInsets.only(left:0 ,right:0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: Color(0xFFedeae6),
                              width: 2.2,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child:CircleAvatar(
                              backgroundImage: NetworkImage(
                                GlobalConfiguration().getString("assetsURL")+orders.products[index].image,
                              ),
                              backgroundColor: Colors.white12,
                              radius: 25,
                            ),
                          ),
                        ),
                        trailing: Column(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: InkWell(
                                child: Icon(Icons.delete,size: 23,color: Colors.red),
                                onTap: () => _deleteDialog(context,orders.products[index].id),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Icon(Icons.edit,size: 23,color: Colors.lightGreen),
                            ),
                          ],
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('${orders.products[index].title}',style: TextStyle(
                              //fontSize: 14,
                                fontSize: ScreenUtil.getInstance().setSp(45),
                                color: Colors.black,fontWeight: FontWeight.bold)),
                            Padding(padding: EdgeInsets.only(top: 4)),
                            Row(
                              children: <Widget>[
                                Text( 'Quality:',style: TextStyle(color: Color(0xFF609f38),
                                    //fontSize: 13,
                                    fontSize: ScreenUtil.getInstance().setSp(40),
                                    fontWeight: FontWeight.bold),
                                ),
                                Text('${orders.products[index].grade == 0 ? 'Premium': 'Regular'}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    //fontSize: 13,
                                    fontSize: ScreenUtil.getInstance().setSp(40),
                                  ),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(top: 2)),
                            Row(
                              children: <Widget>[
                                Text( 'Quantity:',style: TextStyle(color: Color(0xFF609f38),
                                    //fontSize: 13,
                                    fontSize: ScreenUtil.getInstance().setSp(40),
                                    fontWeight: FontWeight.bold),
                                ),
                                Text('${orders.products[index].quantity} ${orders.products[index].unit}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    //fontSize: 13,
                                    fontSize: ScreenUtil.getInstance().setSp(40),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  secondaryActions: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(5,0,0,0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Qty :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(35))),
                              SizedBox(height:17,
                                child: DropdownButton<String>(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF609f38),
                                    size: 22,
                                  ),
                                  items: prod.getWeightList(),
                                  onChanged: (value) {
                                    setState(() {

                                      var wdata = prod.weights.firstWhere((w)=>w.id == value);
                                      var weightdata = wdata.name.split(' ');
                                      var newtotal = weightdata[0];
                                      if(weightdata[1] == 'gm'){
                                        newtotal = (1000/int.parse(weightdata[0]));
                                        newtotal =  orders.products[index].rate/newtotal;
                                        orders.products[index].settotalprice(newtotal);
                                      }
                                      else if(weightdata[1] == 'dz'){
                                        newtotal = orders.products[index].rate * weightdata[0];
                                        orders.products[index].settotalprice(newtotal);

                                      }
                                      else{
                                        print(orders.products[index].rate);
                                        newtotal = orders.products[index].rate * double.parse(weightdata[0]);
                                        orders.products[index].settotalprice(newtotal);
                                      }
                                      orders.calculateorderAmout();
                                      orders.products[index].quantity = weightdata[0];
                                      orders.products[index].unit = weightdata[1];

                                    });
                                  },
                                  underline: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.transparent))
                                    ),
                                  ),

                                  elevation: 16,
                                  //style: TextStyle(color: Colors.black, fontSize: 20),
                                  isDense: true,
                                  //iconSize: 38.0,
                                  iconSize: 28.0,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(2),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
          )
      );
    }
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f0),
      appBar: AppBar(
          title: Text('Edit Order',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(60))),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true
      ),
      body: Container(
        child:Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child:_showitemlist()
              ),
              Card(
                margin: EdgeInsets.only(top: 10),
                elevation: 6,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(255, 255, 255, 9).withOpacity(0.1),
                        Color.fromRGBO (153, 255, 153, 1).withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0, 6],
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Sub Total:',
                            style: TextStyle(
                              //fontSize: 14,
                                fontSize: ScreenUtil.getInstance().setSp(45),
                                fontWeight: FontWeight.bold,color: Colors.grey[500]),
                          ),
                          Text(
                            'Rs:  ${order.orderAmount}',
                            style: TextStyle(
                              //fontSize: 13,
                                fontSize: ScreenUtil.getInstance().setSp(40),
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(6)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Shipping Charges:',
                            style: TextStyle(
                              //fontSize: 14,
                                fontSize: ScreenUtil.getInstance().setSp(45),
                                fontWeight: FontWeight.bold,color: Colors.grey[500]),
                          ),
                          Text(
                            'Rs: ${order.shippingcharge}',
                            style: TextStyle(
                              // fontSize: 13,
                                fontSize: ScreenUtil.getInstance().setSp(40),
                                fontWeight: FontWeight.w600,color:Color(0xFF609f38)),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(6)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total:',
                            style: TextStyle(
                              //fontSize: 16,
                                fontSize: ScreenUtil.getInstance().setSp(45),
                                fontWeight: FontWeight.bold,color:Colors.black),
                          ),
                          //Spacer(),
                          Chip(
                            label: Text(
                              'Rs: ${order.grandtotal} ',
                              style: TextStyle(
                                // color: Theme.of(context).primaryTextTheme.title.color,
                                color: Colors.white,
                                //fontWeight: FontWeight.bold,
                                //fontSize: 14,
                                fontSize: ScreenUtil.getInstance().setSp(40),
                              ),
                            ),
                            backgroundColor:  Color(0xFF609f38),
                          ),
                          //OrderButton(cart: cart)
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MaterialButton(
                            elevation: 10,
                            colorBrightness: Brightness.dark,
                            color: Colors.green,
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Colors.white,
                                width: 0.3,
                                style: BorderStyle.solid
                            ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child:Container(
                              child: Row(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.fromLTRB(5,9,6,9),
                                    child: Icon(Icons.delete,color: Colors.white,size: 20,),
                                  ),
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
                            onPressed:  (){
                              _cancelDialog(context,order.id);
                            },
                          ),
                          MaterialButton(
                            elevation: 10,
                            colorBrightness: Brightness.dark,
                            color: Colors.red,
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Colors.white,
                                width: 0.3,
                                style: BorderStyle.solid
                            ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child:Container(
                              child: Row(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.fromLTRB(5,9,6,9),
                                    child: Icon(Icons.check_circle,color: Colors.white,size: 20,),
                                  ),
                                  Text("Update Order",style: new TextStyle(
                                    //fontSize:12,
                                    fontSize: ScreenUtil.getInstance().setSp(40),
                                    color: Colors.white,
                                    fontFamily: 'Montserrat-Regular',
                                  ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () { _updateDialog(context); },
                          ),
                        ],
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

  _deleteDialog(BuildContext context,itemid) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white70,
            title: Text("Confirm Delete",style: TextStyle(
              //fontSize:17,
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
                          text: 'Delete Item?',
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
                      borderRadius: BorderRadius.circular(50),
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
                      borderRadius: BorderRadius.circular(50),
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
                    onPressed: removeItem(itemid),
                  ),
                ],
              ),
            ],
          );
        }
    );
  }
  removeItem(pId){

  }
  _cancelDialog(BuildContext context,itemid) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white70,
            title: Text("Confirmation",style: TextStyle(
              //fontSize:17,
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
                          text: 'Are you sure to',style: TextStyle(color: Colors.black,
                          //fontSize: 14
                          fontSize: ScreenUtil.getInstance().setSp(60),
                        ),
                        ),
                        TextSpan(
                          text: 'Cancel Editing Order?',
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
                      borderRadius: BorderRadius.circular(50),
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
                      borderRadius: BorderRadius.circular(50),
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
                    onPressed: getorders,
                  ),
                ],
              ),
            ],
          );
        }
    );
  }
  _updateDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white70,
            title: Text("Confirm Order",style: TextStyle(
              //fontSize:17,
                fontSize: ScreenUtil.getInstance().setSp(60),
                color: Colors.black,fontWeight: FontWeight.bold)),
            content: loading == true ? Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
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
                          text: 'update this Order?',
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
                      borderRadius: BorderRadius.circular(50),
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
                    onPressed: (){
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
                      borderRadius: BorderRadius.circular(50),
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
                    onPressed: ()  async {
                      setState(() {
                        loading = true;
                      });
                       var response = await ordersData.updateOrder(orders.id,context);
                      setState(() {
                        loading = false;
                      });
                      if(response['result'] == 1){
                        Fluttertoast.showToast(
                            msg: "Order updated successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: ScreenUtil.getInstance().setSp(40),
                        ).then((val){

                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacementNamed('/');
                        });
                        Navigator.of(context).pushReplacementNamed('/');
                      }
                      else{
                        Fluttertoast.showToast(
                            msg: response['msg'],
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: ScreenUtil.getInstance().setSp(40),
                        );
                      }
                      },
                  ),
                ],
              ),
            ],
          );
        }
    );

  }

  getorders() async {
    var  prefs = await SharedPreferences.getInstance();
    var resp =  prefs.get('userData');
    var user = json.decode(resp);

    var orders = GetOrder(user['token'],user['userId']);
    await orders.getOrders().then((orders){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyOrder(order: orders),
        ),
      );
    });

  }
}
