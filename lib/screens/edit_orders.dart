import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:onlinemandi/providers/database.dart';
import 'package:onlinemandi/providers/orderitem.dart';
import 'package:onlinemandi/providers/orders.dart';
import 'package:onlinemandi/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_drawer.dart';
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

  var unit;
  EditOrderState({orderid}){
      this.orderid = orderid;
  }
  @override
  Widget build(BuildContext context) {
    var ordersData = Provider.of<Orders>(context);
    var orders = ordersData.findOrderbyid(widget.orderid);
    var products = Provider.of<Products>(context);

    var itemlist = orders.products;
    var order = orders;
    Widget _showitemlist(){
      return IconTheme(
          data: new IconThemeData(color: Colors.green),
          child: ListView.builder(
              itemCount: orders.products.length,
              itemBuilder: (BuildContext context,int index) {
               var prod = products.findById(itemlist[index]);
               var pweights = prod.weights;
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.35,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,15,0,18),
                    color: Colors.white,
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
                              GlobalConfiguration().getString("assetsURL")+itemlist[index].image,
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
                              onTap: () => _deleteDialog(context,itemlist[index].id),
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
                          Text('${itemlist[index].title}',style: TextStyle(
                            //fontSize: 14,
                              fontSize: ScreenUtil.getInstance().setSp(40),
                              color: Colors.black,fontWeight: FontWeight.bold)),
                          Padding(padding: EdgeInsets.only(top: 4)),
                          Padding(padding: EdgeInsets.only(top: 3)),
                          Row(
                            children: <Widget>[
                              Text( 'Quantity:',style: TextStyle(color: Color(0xFF609f38),
                                  //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(45),
                                  fontWeight: FontWeight.bold),
                              ),
                              Text('${itemlist[index].quantity} ${itemlist[index].unit}',
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
                                  items: prod.weights.map((value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                  },
                                  underline: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.transparent))
                                    ),
                                  ),
                                  value: "1",
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
                          //Padding(padding: EdgeInsets.all(5)),
                          MaterialButton(
                            elevation: 15,
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
                                  Padding(padding: EdgeInsets.fromLTRB(5,0,5,0),
                                    child: Icon(Icons.edit,color: Colors.white,size: 15),
                                  ),
                                  Center(
                                    child: Text("Update",style: new TextStyle(
                                      //fontSize:12,
                                      fontSize: ScreenUtil.getInstance().setSp(35),
                                      color: Colors.white,
                                      fontFamily: 'Montserrat-Regular',
                                    )),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
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
                child: Padding(
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
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
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
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        }
    );
  }
}
