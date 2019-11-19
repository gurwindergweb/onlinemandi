import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ChangePassword extends StatefulWidget {
  @override
  ChangePasswordState createState() => ChangePasswordState();
  static const routeName = '/changepassword';
}
class ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Change Password',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,0,0,10),
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Enter Old Password',
                            border: OutlineInputBorder()
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,0,0,10),
                      child:
                       TextField(
                          decoration: InputDecoration(
                              labelText: 'Enter New Password',
                              border: OutlineInputBorder()
                          ),
                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,0,0,10),
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder()
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
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
                                Padding(padding: EdgeInsets.fromLTRB(5,9,6,9),
                                  child: Icon(Icons.cancel,size: 20),
                                ),
                                Text("Cancel",style: new TextStyle(
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
                        MaterialButton(
                          elevation: 9,
                          //minWidth: 180.0,
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
                                  child: Icon(Icons.check_circle,size: 20),
                                ),
                                Text("Update",style: new TextStyle(
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
