import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:onlinemandi/providers/database.dart';
import 'package:onlinemandi/providers/weights.dart';
import 'package:onlinemandi/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:link/link.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatefulWidget{
  @override
  ProductItemState createState() => ProductItemState();

}
class ProductItemState extends State<ProductItem> {
  // final String id;
  // final String title;
  // final String imageUrl;
  var dbprovider = DBProvider();
  var weightdata;
  // ProductItem(this.id, this.title, this.imageUrl);
  var selectedweight;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
              color: Colors.white,
              border: Border.all(
                color: Colors.white12,
                style: BorderStyle.solid,
                width: 2.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 35,
                  //padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  //color: Colors.red,
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.title + " (" + product.description + ")",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          product.isFavorite ? Icons.favorite : Icons.favorite_border,
                        ),
                        iconSize: 23,
                        alignment: Alignment(0.0, -2.0),
                        //color: Theme.of(context).accentColor,
                        color: Colors.redAccent,
                        onPressed: () {
                          product.toggleFavoriteStatus(
                            authData.token,
                            authData.userId,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 18),
                      child:Image.network(
                        GlobalConfiguration().getString("assetsURL") + product.imageUrl,
                        //fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Expanded(
                      /*1*/
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*2*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Quality: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  //fontFamily: 'Lato-Bold',
                                ),
                              ),
                              Text(
                                product.quality ? 'Premium' : 'Regular',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Rs ' + product.price.toString() + "/Kg",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF609f38),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10)),
                              /* Image.asset(
                                'images/online-logo.png',
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),*/
                            ],
                          ),
                          /*Text(
                            'Offers !',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        footer: Container(
          padding: EdgeInsets.fromLTRB(0,10,0,10),
          child: GridTileBar(
            leading: Consumer<Product>(
                builder: (ctx, product, _){
                  return Container(

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
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 8),
                          child: new Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.white,
                            ),
                            child: /*DropdownButton<String>(
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
                                style: TextStyle(color: Color(0xFF609f38),fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "2",
                              child: Text(
                                "1 kg",style: TextStyle(color: Color(0xFF609f38),fontSize: 16),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                          },
                          value: "1",
                          elevation: 16,
                          //style: TextStyle(color: Colors.black, fontSize: 20),
                          isDense: true,
                          iconSize: 38.0,
                        ),*/
                            new DropdownButton<String>(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xFF609f38),
                                size: 35,
                              ),

                              /* items: product.weights.map((value) {
                            return new DropdownMenuItem<String>(
                              value: value.id,
                              child: new Text(value.name,style: TextStyle(color: Color(0xFF609f38),fontSize: 16),

                            ));
                          }).toList(),*/
                            items: [
                            DropdownMenuItem<String>(
                            value:'tr',
                              child: new Text('ccc',style: TextStyle(color: Color(0xFF609f38),fontSize: 16),

                              ))
                            ],

                              onChanged: (val) {
                                setState(() {
                                  selectedweight = val;
                                });

                              },
                              value: selectedweight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
            ),
            title: MaterialButton(
               elevation: 8,
              /*//minWidth: 90.0,
              height: 40.0,
              colorBrightness: Brightness.dark,
              color:  Colors.red,
              shape: RoundedRectangleBorder(side: BorderSide(
                  color: Colors.red,
                  width: 1.3,
                  style: BorderStyle.solid
              ),
                //borderRadius: BorderRadius.circular(40),
              ),*/
              child:Container(
                child:/* Text("Offers*",style: new TextStyle(
                   fontSize:13,
                   color: Colors.red,
                   fontFamily: 'Montserrat-Regular',
                  ),
                ),*/
                //Icon(Icons.local_offer,color: Colors.red),
                Image.asset(
                  'images/special.png',
                  //width: 200,
                  //height: 100,
                  //fit: BoxFit.cover,
                ),
              ),
              onPressed: () => _displayDialog(context),
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
              elevation: 8,
              //minWidth: 100.0,
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
                cart.addItem(product.id, product.price, product.title);
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
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

  }
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight:  const  Radius.circular(30.0),
                  bottomLeft:  const  Radius.circular(30.0),
                ),
            ),
            contentPadding: EdgeInsets.all(14.0),
            titlePadding: EdgeInsets.all(0.0),
            // backgroundColor: Color(0xFF609f38),
            title: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xFF609f38),
                borderRadius: BorderRadius.only(
                  topRight:  const  Radius.circular(30.0),
                  bottomLeft:  const  Radius.circular(0.0),
                ),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'images/online-logo1.png',
                        width: 80,
                        height: 80,
                    ),
                    Text("Today's offers!",style: TextStyle(fontSize:22,color: Colors.white,fontWeight: FontWeight.bold)),
                  ],
                ),
                //Text("Today's Offers!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              ),
            ),
            content: SingleChildScrollView(
              //width: MediaQuery.of(context).size.width * 1.1,
              //height: MediaQuery.of(context).size.height * 0.3,
              child: ListBody(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Buy 5 kg get 6 apple piece free! ',style: TextStyle(color: Colors.black,fontSize: 16),
                        ),
                        TextSpan(
                          text: 'Apply now',
                          style: TextStyle(
                            color: Colors.blue,
                            //color: Color(0xFF609f38),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Buy 3 kg get 4 apple piece free! ',style: TextStyle(color: Colors.black,fontSize: 16),
                        ),
                        TextSpan(
                            text: 'Apply now',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                            ),
                        ),
                      ],
                   ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                ],
              ),
            ),
            actions: <Widget>[
              new MaterialButton(
                elevation: 9,
                //minWidth: 100.0,
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
                      Padding(padding: EdgeInsets.fromLTRB(5,9,6,9),
                        //child: Icon(Icons.exit_to_app,color: Colors.white),
                      ),
                      Text("Not Now *",style: new TextStyle(
                        fontSize:12,
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
          );
        });

  }
  TextEditingController _textFieldController = TextEditingController();
}
