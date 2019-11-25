import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:onlinemandi/providers/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_drawer.dart';
//import 'confirm_order.dart';

class EditOrder extends StatefulWidget {
  var orderitem;
  var weight;
  var dbprovider = DBProvider();
  EditOrder({order}){
  this.orderitem = order;
  //print(this.orderitem);

  }

  @override
  EditOrderState createState() => EditOrderState(order:orderitem);
  static const routeName = '/editorder';
}
class EditOrderState extends State<EditOrder> {
  var weight;
  var orderitem ;
  EditOrderState({order}){
    this.orderitem = order;
    //print(this.orderitem);

  }
  @override
  initState(){
    print(widget.orderitem);
   // getweight(this.orderitem['items'][0]['q']);
  }
  getweight(wid) async {
    var dbprovider = DBProvider();
    var dbclient = await dbprovider.database;
    var weightdata = await dbprovider.getweight(wid);
    setState(){
      this.weight = weightdata[0]['name'];
    }
  }
  @override
  Widget build(BuildContext context) {
   // print(this.orderitem);
    // getweight(this.orderitem['item'][0]['q']);
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
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
              Card(
                elevation:6,
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
                        margin: const EdgeInsets.only(left:0 ,right:10),
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
                                GlobalConfiguration().getString("assetsURL")+this.orderitem['items'][0]['img'],
                            ),
                            backgroundColor: Colors.white12,
                            radius: 25,
                          ),
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: InkWell(
                              child: Icon(Icons.delete,size: 23,color: Colors.red),
                              onTap: () => _displayDialog(context),
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
                          Text('${widget.orderitem['items'][0]['n']}',style: TextStyle(
                              //fontSize: 14,
                              fontSize: ScreenUtil.getInstance().setSp(45),
                              color: Colors.black,fontWeight: FontWeight.bold)),
                          Padding(padding: EdgeInsets.all(1)),
                          Row(
                            children: <Widget>[
                              Text('Grade: ',style: TextStyle(color: Colors.black,
                                //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text( '${widget.orderitem['items'][0]['g']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(1)),
                          Row(
                            children: <Widget>[
                              Text('Quantity: ',style: TextStyle(color: Color(0xFF609f38),
                                  //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                  fontWeight: FontWeight.bold),
                              ),
                              Text('${this.weight} ${widget.orderitem['items'][0]['u']} ',
                                style: TextStyle(
                                  color: Colors.black,
                                  //fontSize: 13,
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                ),
                              ),
                            ],
                          ),
                          //Text('Quantity: 2kg',style: TextStyle(fontSize: 13,color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
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
                            'Rs: ${widget.orderitem['pt']} ',
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
                            'Rs: ${widget.orderitem['dc']}',
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
                              'Rs: ${widget.orderitem['gt']} ',
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
                                  Text("Active Orders",style: new TextStyle(
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
                                  Text("Update Orders",style: new TextStyle(
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
  _displayDialog(BuildContext context) async {
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
