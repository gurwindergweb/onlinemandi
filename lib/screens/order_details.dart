import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:onlinemandi/providers/database.dart';
import '../widgets/app_drawer.dart';
import 'edit_orders.dart';
//import 'confirm_order.dart';
//import 'edit_orders.dart';

class OrderDetails extends StatefulWidget {
  var orderDetails;

  OrderDetails({orderdetail}){
    this.orderDetails = orderdetail;
  }

  @override
  OrderDetailsState createState() => OrderDetailsState();
  static const routeName = '/orderdetails';
}
class OrderDetailsState extends State<OrderDetails> {
  var weight;
  var loadedweight = false;
  var orderDetails;
  OrderDetailsState({order}){
    this.orderDetails = order;

  }
  getweight(wid) async {
    var dbprovider = DBProvider();
    var dbclient = await dbprovider.database;
    var weightdata = await dbprovider.getweight(wid);
    setState(() {
      this.weight = weightdata[0]['name'];
      loadedweight = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    this.weight ==null? getweight(widget.orderDetails['items'][0]['q']): null;
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
                      Text('Order Date: ${widget.orderDetails['date']}',style: TextStyle(color: Color(0xFF609f38),fontWeight: FontWeight.bold,
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
                          Text('${widget.orderDetails['id']}',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(40))),
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
                          Text('${widget.orderDetails['ic']}',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(40))),
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
                          Text('${widget.orderDetails['pt']}',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(40))),
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
                          Text('${widget.orderDetails['dc']}',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(40))),
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
                          Text('${widget.orderDetails['gt']}',style: TextStyle(color: Colors.black,fontSize: ScreenUtil.getInstance().setSp(40))),
                        ],
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //Text('City:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color:Colors.white)),
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
                            onPressed: () => _displayDialog(context),
                          ),
                          MaterialButton(
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
                               Navigator.of(context).pushNamed(EditOrder.routeName);
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => EditOrder(order: widget.orderDetails),
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
              Card(
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
                            GlobalConfiguration().getString("assetsURL")+widget.orderDetails['items'][0]['img'],
                            height: 100,
                            width: 100,
                            ),
                          /*CircleAvatar(
                            backgroundImage: AssetImage(
                              'images/download (1).jpg',
                            ),
                            backgroundColor: Colors.white12,
                            radius: 25,
                          ),*/
                        ),
                      ),
                      /*trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Icon(Icons.delete,size: 23,color: Colors.red),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Icon(Icons.edit,size: 23,color: Colors.lightGreen),
                          ),
                        ],
                      ),*/
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('${widget.orderDetails['items'][0]['n']}',style: TextStyle(
                              //fontSize: 14,
                              fontSize: ScreenUtil.getInstance().setSp(45),
                              color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Row(
                            children: <Widget>[
                              Text(
                                'Grade: ',style: TextStyle(color: Color(0xFF609f38),
                                  //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                  fontWeight: FontWeight.bold),
                              ),
                              Text( '${widget.orderDetails['items'][0]['g']}',
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
                              Text('${this.weight} ${widget.orderDetails['items'][0]['u']}',
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
                              Text( '${widget.orderDetails['items'][0]['r']}/kg',
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
                              Text('${widget.orderDetails['items'][0]['tp']}/kg',
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
              ),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  _displayDialog(BuildContext context) async {
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
