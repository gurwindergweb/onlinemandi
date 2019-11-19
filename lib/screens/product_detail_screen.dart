import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f0),
      appBar: AppBar(
        title: Text(loadedProduct.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF609f38),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
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
                          'Rs:',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        '${loadedProduct.price}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(right: 10,top: 2),
                        child: Text(
                          'itme:',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        'Green Apple',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
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
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        'Normal',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,0),
                    child: GridTileBar(
                      leading: Container(
                            //color: Colors.lightGreen,
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 10),
                                  child: new Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Colors.white,
                                  ),
                                  child: DropdownButton<String>(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xFF609f38),
                                      size: 35,
                                    ),
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: "1",
                                        child: Text(
                                          "900gm",
                                          style: TextStyle(color: Color(0xFF609f38),fontSize: 16,fontFamily: 'Lato',fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "2",
                                        child: Text(
                                          "1 kg",style: TextStyle(color: Color(0xFF609f38),fontSize: 16,fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                    },
                                    value: "1",
                                    elevation: 9,
                                    //style: TextStyle(color: Colors.black, fontSize: 20),
                                    isDense: true,
                                    iconSize: 40.0,
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
                      /*title: Text(
                      'Offers !',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),*/
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
                                fontSize:15,
                                fontFamily: 'Montserrat-Regular',
                              ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          //cart.addItem(product.id, product.price, product.title);
                          Scaffold.of(context).hideCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added item to cart!',
                              ),
                              duration: Duration(seconds: 3),
                              action: SnackBarAction(
                                label: 'UNDO',
                                textColor: Color(0xFF609f38),
                                onPressed: () {
                                  //cart.removeSingleItem(product.id);
                                },
                              ),
                            ),
                          );
                        },
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
                        fontSize: 20,
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
                         fontSize: 16,
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
                    fontSize: 17,
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
                        'Tempt your taste buds with tart Granny Smith apples! Known for its delicious tart flavor and pleasing crunch,  Known for its delicious tart flavor and pleasing crunch, the Granny Smith apple’s popularity comes as no surprise. What’s more, it’s a go-to apple variety for snacking and is a favorite of pie bakers. Granny Smiths are great in all kinds of recipes, such as salads, sauces, baking, freezing, and more. Tempt your taste buds with tart Granny Smith apples! Known for its delicious tart flavor and pleasing crunch,  Known for its delicious tart flavor and pleasing crunch, the Granny Smith apple’s popularity comes as no surprise. What’s more, it’s a go-to apple variety for snacking and is a favorite of pie bakers.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
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
