import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class MyOrder extends StatefulWidget {
  @override
  MyOrderState createState() => MyOrderState();
  static const routeName = '/myorder';
}
class MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Order Details',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true
      ),
      body: Container(
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
          children: <Widget>[
            Card(
              elevation: 12,
              child: Container(
                padding: EdgeInsets.all(5),
                child:  ListTile(
                  title: Text('Total Orders:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                  subtitle: Padding(
                    padding: EdgeInsets.fromLTRB(0,20,0,5),
                    child: Text('Total Purchase:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                  ),
                  trailing: Padding(
                    padding: EdgeInsets.all(1),
                    child: Column(
                      children: <Widget>[
                        Text('0',style: TextStyle(color: Color(0xFF609f38),fontWeight: FontWeight.w600,fontSize: 16)),
                        Padding(padding: EdgeInsets.all(8)),
                        Text('Rs: 250.00',style: TextStyle(color: Color(0xFF609f38),fontWeight: FontWeight.w600,fontSize: 16)),
                      ],
                    ),
                  ),
                  leading: Padding(
                    padding: EdgeInsets.fromLTRB(0,0,0,5),
                    child: Icon(Icons.shopping_basket,color: Color(0xFF609f38),size:30),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 12,
              child: ListTile(
                title: Text('Active Orders (0)',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                /*subtitle:  Padding(
                  padding: EdgeInsets.fromLTRB(0,5,0,5),
                  child: Text('Customer Support Numbers:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14,)),
                ),*/
                trailing:Icon(Icons.arrow_forward_ios,color: Color(0xFF609f38),size: 18),
                leading: Padding(
                  padding: EdgeInsets.fromLTRB(0,8,0,5),
                  child: Icon(Icons.access_time,color: Color(0xFF609f38)),
                ),
              ),
            ),
            Card(
              elevation: 12,
              child: ListTile(
                title: Text('Completed Orders (0)',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                /*subtitle:  Padding(
                  padding: EdgeInsets.fromLTRB(0,5,0,5),
                  child: Text('Customer Support Numbers:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14,)),
                ),*/
                trailing:Icon(Icons.arrow_forward_ios,color: Color(0xFF609f38),size: 18),
                leading: Padding(
                  padding: EdgeInsets.fromLTRB(0,8,0,5),
                  child: Icon(Icons.check_circle_outline,color: Color(0xFF609f38)),
                ),
              ),
            ),
            Card(
              elevation: 12,
              child: ListTile(
                title: Text('Cancelled Orders (0)',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                /*subtitle:  Padding(
                  padding: EdgeInsets.fromLTRB(0,5,0,5),
                  child: Text('Customer Support Numbers:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14,)),
                ),*/
                trailing:Icon(Icons.arrow_forward_ios,color: Color(0xFF609f38),size: 18),
                leading: Padding(
                  padding: EdgeInsets.fromLTRB(0,8,0,5),
                  child: Icon(Icons.cancel,color: Color(0xFF609f38)),
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
