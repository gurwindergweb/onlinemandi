import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:onlinemandi/providers/product.dart';
import 'package:onlinemandi/providers/products.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';
import 'checkout.dart';

class CartScreen extends StatefulWidget{
  static const routeName = '/cart';
  @override
  CartScreenState createState() => CartScreenState();
}
class CartScreenState extends State<CartScreen> {
  Product prod;
  var products;
  Cart cart;

  var p_id;

  @override
  Widget build(BuildContext context) {
     cart = Provider.of<Cart>(context);
     print(cart);
     products = Provider.of<Products>(context);
     ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f0),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Your Cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF609f38),
        centerTitle: true,
        //centerTitle: true,
        actions: <Widget>[
          Padding(padding: EdgeInsets.all(10),
          child: cart.items.keys.length> 0 ? InkWell(
            child: Icon(Icons.delete_sweep, color: Colors.white),
            onTap: (){_clearDialog(context);},
          ): null
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            child: Expanded(
              child: cart.items.keys.length> 0 ? ListView.builder(
                  itemCount: cart.items.keys.length,

                  itemBuilder: (ctx, i){
                    var ct = cart.items.keys.toList();
                    if(ct[i].contains('_')){
                       var data = ct[i].split('_');
                       p_id = data[0];
                    }
                    else{
                       p_id = ct[i];
                    }
                    prod = products.find(p_id,cart.items[ct[i]].grade);
                    final SlidableController slidableController = SlidableController();
                    return  Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      controller: slidableController,

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
                                  GlobalConfiguration().getString("assetsURL")+cart.items['${ct[i]}'].image,
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
                                  onTap: (){
                                    _clearSingleItemDialog(context,ct[i]);
                                  },
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
                              Text('${cart.items['${ct[i]}'].title}',style: TextStyle(
                                  //fontSize: 14,
                                   fontSize: ScreenUtil.instance.setSp(40),
                                  color: Colors.black,fontWeight: FontWeight.bold)),
                              Padding(padding: EdgeInsets.only(top: 4)),
                              Padding(padding: EdgeInsets.only(top: 3)),
                              Row(
                                children: <Widget>[
                                  Text( 'Quantity:',style: TextStyle(color: Color(0xFF609f38),
                                     // fontSize: 13,
                                      fontSize: ScreenUtil.instance.setSp(45),
                                      fontWeight: FontWeight.bold),
                                  ),
                                  Text('${cart.items['${ct[i]}'].quantity} ${cart.items['${ct[i]}'].unit}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      //fontSize: 13,
                                      fontSize: ScreenUtil.instance.setSp(40),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text( 'Quality:',style: TextStyle(color: Color(0xFF609f38),
                                      // fontSize: 13,
                                      fontSize: ScreenUtil.instance.setSp(45),
                                      fontWeight: FontWeight.bold),
                                  ),
                                  Text('${cart.items['${ct[i]}'].grade == 0 ? 'Premium' : 'Regular' }',
                                    style: TextStyle(
                                      color: Colors.black,
                                      //fontSize: 13,
                                      fontSize: ScreenUtil.instance.setSp(40),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text( 'Total: ',style: TextStyle(color: Color(0xFF609f38),
                                      // fontSize: 13,
                                      fontSize: ScreenUtil.instance.setSp(45),
                                      fontWeight: FontWeight.bold),
                                  ),
                                  Text('Rs ${cart.items['${ct[i]}'].totalprice}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      //fontSize: 13,
                                      fontSize: ScreenUtil.instance.setSp(40),
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
                                  Text('Qty :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil.instance.setSp(35))),
                                  SizedBox(height:17,
                                    child: DropdownButton<String>(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xFF609f38),
                                        size: 22,
                                      ),
                                      items: prod.getWeightList(),
                                      onChanged: (value) {
                                        //prod = products.findById(p_id);
                                        setState(() {
                                          var wdata = prod.weights.firstWhere((w)=>w.id == value);
                                          var weightdata = wdata.name.split(' ');
                                          var newtotal = weightdata[0];
                                          if(weightdata[1] == 'gm'){
                                            newtotal = (1000/int.parse(weightdata[0]));
                                            newtotal =  prod.price/newtotal;
                                            cart.items['${ct[i]}'].settotalprice(newtotal);
                                          }
                                          else if(weightdata[1] == 'dz'){
                                            newtotal = prod.price * weightdata[0];
                                            cart.items['${ct[i]}'].settotalprice(newtotal);

                                          }
                                          else{
                                            newtotal = prod.price * double.parse(weightdata[0]);
                                            cart.items['${ct[i]}'].settotalprice(newtotal);
                                          }
                                          cart.grandTotal;
                                          cart.items['${ct[i]}'].quantity = weightdata[0];
                                          cart.items['${ct[i]}'].unit = weightdata[1];

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
              ) : Center(child: Text('Empty Cart!'),)
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Sub Total:',
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey[500]),
                      ),
                      Text(
                        'Rs: ${cart.totalAmount}',
                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(6)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Shipping Charges:',
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey[500]),
                      ),
                      Text(
                        'Rs: ${cart.shippingcharge != null ? cart.shippingcharge : 0.0}',
                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color:Color(0xFF609f38)),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(6)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total:',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                      //Spacer(),
                      Chip(
                        label: Text(
                          'Rs ${cart.grandTotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            // color: Theme.of(context).primaryTextTheme.title.color,
                            color: Colors.white,
                            //fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        backgroundColor:  Color(0xFF609f38),
                      ),
                      OrderButton(cart: cart)
                    ],
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
  _clearDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
          return AlertDialog(
            backgroundColor: Colors.white70,
            title: Text("Clear Cart",style: TextStyle(
              //fontSize:17,
                fontSize: ScreenUtil.instance.setSp(60),
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
                          text: 'clear cart?',
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
                    onPressed: (){
                      cart.clear();
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
  _clearSingleItemDialog(BuildContext context,itemid) async {
    return showDialog(
        context: context,
        builder: (context) {
          ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
          return AlertDialog(
            backgroundColor: Colors.white70,
            title: Text("Remove Item",style: TextStyle(
              //fontSize:17,
                fontSize: ScreenUtil.instance.setSp(60),
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
                          text: 'Remove this item?',
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
                    onPressed: (){
                      cart.removeItem(itemid.toString());
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    /*return MaterialButton(
      elevation: 8,
      //minWidth: 100.0,
      //height: 40.0,
      colorBrightness: Brightness.dark,
      color: new Color(0xFF609f38),
      shape: RoundedRectangleBorder(side: BorderSide(
          color: Colors.white,
          width: 1.3,
          style: BorderStyle.solid
      ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: _isLoading ? CircularProgressIndicator() : Text('Checkout',style: TextStyle(color: Colors.white,fontSize: 12)),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
      textColor: Theme.of(context).primaryColor,
    );*/
    return MaterialButton(
      elevation: 8,
      //minWidth: 100.0,
      //height: 40.0,
      colorBrightness: Brightness.dark,
      color: new Color(0xFF609f38),
      shape: RoundedRectangleBorder(side: BorderSide(
          color: Colors.white,
          width: 1.3,
          style: BorderStyle.solid
      ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: _isLoading ? CircularProgressIndicator() : Text('Checkout',style: TextStyle(color: Colors.white,fontSize: 12)),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () {
              Navigator.of(context).pushNamed(Checkout.routeName);
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
