import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onlinemandi/providers/Utilities.dart';
import 'package:onlinemandi/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../widgets/app_drawer.dart';
import 'auth_screen.dart';

class ChangePassword extends StatefulWidget {
  @override
  ChangePasswordState createState() => ChangePasswordState();
  static const routeName = '/changepassword';
}
class ChangePasswordState extends State<ChangePassword> {
  var npass = TextEditingController();
  var opass = TextEditingController();
  var cpass = TextEditingController();
  var auth = Auth();

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
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Enter Old Password',
                            border: OutlineInputBorder()
                        ),
                        controller: opass,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,0,0,10),
                      child:
                       TextField(
                         obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Enter New Password',
                              border: OutlineInputBorder()
                          ),
                         controller: npass,

                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,0,0,10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder()
                        ),
                        controller: cpass,

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
                          onPressed: updatepass,
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
  updatepass() async {
    if(opass.text !='' && npass.text !='' && cpass.text !=''){
      if(npass.text.length > 7 && npass.text.length < 12){
        if(npass.text == cpass.text){
          var prefs = await SharedPreferences.getInstance();
          var userdata = json.decode(prefs.get('userData'));
          print(userdata);
          var utilities = Utilities(userdata['token'],userdata['userId']);
          utilities.checkoldpass(opass.text).then((response){
            print(response);
            if(response == true){
              utilities.changepassword(npass.text).then((changeresp) async {
                if(changeresp == 'success'){
                  await Fluttertoast.showToast(
                      msg: "Password changed successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 14.0
                  ).then((val){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/');
                    Provider.of<Auth>(context, listen: false).logout();
                  });

                }
                else{
                  Fluttertoast.showToast(
                      msg: changeresp,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 14.0
                  );
                }
              });

              /*auth.changepassword(npass.text).then((resp){
                print(resp);
              });*/
            }
            else{
              Fluttertoast.showToast(
                  msg: 'Incorrect old password!',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 14.0
              );
            }
          });
        }
        else{
          Fluttertoast.showToast(
              msg: "Password does not match",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 14.0
          );
          //

        }
      }
      else{
        Fluttertoast.showToast(
            msg: "Password length should be between 8-11 characters",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0
        );
      }

    }
    else{
      Fluttertoast.showToast(
          msg: "Please fill all feilds",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0
      );
    }
  }
}
