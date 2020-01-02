import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:onlinemandi/providers/cart.dart';
import 'package:onlinemandi/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import 'cart_screen.dart';
class ProductDetailScreen extends StatefulWidget{
  static const routeName = '/product-detail';
  @override
  ProductDetailScreenState createState()  => ProductDetailScreenState();
}
class ProductDetailScreenState extends State<ProductDetailScreen> {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);


  String selectedweight;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f0),
      appBar: AppBar(
        title: Text(loadedProduct.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(60))),
        backgroundColor: Color(0xFF609f38),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 210,
              width: double.infinity,
              child: Image.network(
                GlobalConfiguration().getString("assetsURL") + loadedProduct.imageUrl,
                //fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0,10,0,5),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right: 10,top: 2),
                        child: Text(
                          'Rs: ${loadedProduct.price}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            //fontSize: 16,
                            fontSize: ScreenUtil.getInstance().setSp(45),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right: 10,top: 2),
                        child: Text(

                          'item:',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            //fontSize: 16,
                            fontSize: ScreenUtil.getInstance().setSp(45),
                          ),
                        ),
                      ),
                      Text(
                        '${loadedProduct.title} (${loadedProduct.description}) ',
                        style: TextStyle(
                          color: Colors.black,
                          //fontSize: 16,
                          fontSize: ScreenUtil.getInstance().setSp(45),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right: 10,top: 2),
                        child: Text(
                          'Quality:',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            //fontSize: 16,
                            fontSize: ScreenUtil.getInstance().setSp(45),
                          ),
                        ),
                      ),
                      Text(
                        loadedProduct.grade == 0 ? 'Premium' :  'Regular',
                        style: TextStyle(
                          color: Colors.black,
                          //fontSize: 16,
                          fontSize: ScreenUtil.getInstance().setSp(45),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,0),
                    child: GridTileBar(
                      leading: Container(
                            //color: Colors.lightGreen,
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2.0)),
                              color: Color(0xFF609f38),
                              border: Border.all(
                                color: Color(0xFF609f38),
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Row(
                              children:[
                                Text(
                                  'Quantity: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    //fontSize: 18,
                                    fontSize: ScreenUtil.getInstance().setSp(50),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  //width: 90,
                                  padding: EdgeInsets.only(left: 8),
                                  child: new Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Colors.white,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: new DropdownButton<String>(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xFF609f38),
                                        size: 30,
                                      ),
                                      items: loadedProduct.getWeightList(),

                                      onChanged: (val) {
                                        setState(() {
                                          selectedweight = val;
                                        });
                                      },
                                      value: selectedweight!= null ? selectedweight : loadedProduct.selectedweight,
                                    ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      title: Text(
                        'hii',
                        textAlign: TextAlign.center,
                      ),
                      trailing: MaterialButton(
                        elevation: 6.0,
                        minWidth: 100.0,
                        height: 40.0,
                        colorBrightness: Brightness.dark,
                        color: new Color(0xFF609f38),
                        shape: RoundedRectangleBorder(side: BorderSide(
                            color: Colors.white,
                            width: 1.3,
                            style: BorderStyle.solid
                        ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child:Container(
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.fromLTRB(5,9,6,9),
                                child: Icon(Icons.add_shopping_cart,color: Colors.white),
                              ),
                              Text("Add",style: new TextStyle(
                                //fontSize:15,
                                fontSize: ScreenUtil.getInstance().setSp(45),
                                fontFamily: 'Montserrat-Regular',
                              ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: loadedProduct.grade != -1 ? () {
                          if(loadedProduct.price>0){
                            cart.addItem(productId: loadedProduct.id, image: loadedProduct.imageUrl,grade: loadedProduct.grade, price: loadedProduct.price, title: loadedProduct.title, quantity: selectedweight != null ? int.parse(selectedweight) : int.parse(loadedProduct.selectedweight));
                            Fluttertoast.showToast(
                                msg: "Added item to cart",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                          else{
                            Scaffold.of(context).hideCurrentSnackBar();
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Can't item to cart!",
                                ),
                                duration: Duration(seconds: 3),

                              ),
                            );
                          }
                        } : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0,5,0,10),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 Text(
                      'Offers !',
                      style: TextStyle(
                        color: Colors.red,
                        //fontSize: 20,
                        fontSize: ScreenUtil.getInstance().setSp(50),
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),

                  ),
                 Padding(padding: EdgeInsets.all(5)),
                 Row(
                   children: <Widget>[
                     Expanded(
                       child:Text(
                       'Buy 1 kg get 1 apple piece free!',
                       style: TextStyle(
                         color: Colors.black,
                         fontWeight: FontWeight.bold,
                         //fontSize: 16,
                         fontSize: ScreenUtil.getInstance().setSp(45),
                       ),
                     ),
                     ),
                   ],
                 ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(15,5,10,5),
              child:Row(
                children: <Widget>[
                  Text('Description:',style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    //fontSize: 17,
                    fontSize: ScreenUtil.getInstance().setSp(50),
                  )),
                ],
               ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0,0,0,10),
              padding: EdgeInsets.fromLTRB(15,0,10,5),
              height:200,
              child: ListView(
                 children: <Widget>[
                    SingleChildScrollView(
                      child: Text(
                        loadedProduct.description,
                        style: TextStyle(
                          color: Colors.black,
                          //fontSize: 15,
                          fontSize: ScreenUtil.getInstance().setSp(45),
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
