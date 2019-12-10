import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatefulWidget{
  String id;
  int productId;
  double price;
  String quantity;
  String unit;
  String title;
  String image;
  @override
   _CartItemState createState() => _CartItemState(id,productId,price,quantity,unit,title,image);
  CartItem(
      this.id,
      this.productId,
      this.price,
      this.quantity,
      this.unit,
      this.title,
      this.image,
      );

}
class _CartItemState extends State<CartItem>{
  String id;
  int productId;
  double price;
  String quantity;
  String unit;
  String title;
  String image;
  _CartItemState(
      this.id,
      this.productId,
      this.price,
      this.quantity,
      this.unit,
      this.title,
      this.image,
      );


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text(
                  'Do you want to remove the item from the cart?',
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                  ),
                ],
              ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId.toString());
      },
      child: Card(
        elevation:2,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Container(
          //height: 120,
          //padding: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(10),
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
                    backgroundImage: NetworkImage(GlobalConfiguration().getString("assetsURL")+image),
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
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(Icons.delete,size: 22,color: Colors.red),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(Icons.edit,size: 22,color: Colors.lightGreen),
                  ),
                ],
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(title,style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold)),
                  Text('Quantity \: $quantity $unit',style: TextStyle(fontSize: 14,color: Colors.black)),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text('Total:  Rs ${price }',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
