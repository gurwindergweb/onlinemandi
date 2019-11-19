import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_drawer.dart';

class UserDetail extends StatefulWidget {
  @override
  UserDetailState createState() => UserDetailState();
  static const routeName = '/userdetail';
}

class UserDetailState extends State<UserDetail> {
  var resp;
  var userData;
  var prefs;
  @override
  void initState() {
    getuserdetail();
  }
  getuserdetail() async {
     prefs = await SharedPreferences.getInstance();
     resp = prefs.get('userData');
     setState(() {
       userData = json.decode(resp);
     });
  }
  editnumber(){
    smsOTPDialog(context).then((val){

    });
  }
  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(1),
                  height:100,
                  width:100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: Color.fromRGBO(76,165,13 ,1),
                      width: 2.2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Icon(Icons.perm_phone_msg,color: Color.fromRGBO(76,165,13 ,1),size:62),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0,2,0,2)),
                Text('Edit Your Number!',style: TextStyle(color:Color.fromRGBO(76,165,13 ,1),fontWeight: FontWeight.bold,fontSize: 18)),

              ],
            ),
            content: TextField(
              keyboardType :
              TextInputType.number,
              onChanged: (value) {

              },
            ),

            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              MaterialButton(
                elevation: 10.0,
                minWidth: 150,
                height: 45.0,
                colorBrightness: Brightness.dark,
                color: new Color(0xFFFDB60C),
                shape: RoundedRectangleBorder(side: BorderSide(
                    color: Colors.white30,
                    width: 1.3,
                    style: BorderStyle.solid
                ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text( 'Verify',style: TextStyle(color: Colors.white)),
                onPressed: (){

                },
              )
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    //getuserdetail();
   print(userData);
    return Scaffold(
      appBar: AppBar(
          title: Text('Profile',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF609f38),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          //automaticallyImplyLeading: true, // Don't show the leading button

          actions: <Widget>[
            //Icon(Icons.keyboard_backspace),
            /*onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },*/
          ],
      ),
      body: Container(
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
                border: Border.all(
                  width: 2.2,
                  color: Color(0xFF609f38)
                ),
              ),
              child: Stack(
                alignment: const Alignment(0.9, 1.0),
                children: [
                  Icon(Icons.person,size:82,color: Color(0xFF609f38)),
                  /*CircleAvatar(
                    backgroundImage: AssetImage('images/download.jpg'),
                    radius: 80,
                    backgroundColor: Color(0xFFededdf),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      color: Colors.white12,
                    ),
                    child: Icon(Icons.camera_enhance,size:30,color: Colors.white),
                  ),*/
                  ],
                ),
              ),
              Divider(
                color: Colors.black38,
              ),
              ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        width: 1.2,
                        color: Color(0xFF609f38),
                      ),
                    ),
                    child: Icon(Icons.person,color: Color(0xFF609f38),size: 24),
                  ),
                  title: Text(userData['username'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                  subtitle: Text(userData['email'],style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal)),
              ),
              Divider(
                color: Colors.black38,
              ),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      width: 1.2,
                      color: Color(0xFF609f38),
                    ),
                  ),
                  child: Icon(Icons.phone,color: Color(0xFF609f38),size: 24),
                ),
                title: Text('Phone Number.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                subtitle: Text(userData['contact1'],style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal)),
                trailing:
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    color: Colors.white12,
                  ),
                  child: InkWell(
                    child: Icon(Icons.edit,size:25,color: Color(0xFF609f38)),
                    onTap: editnumber,
                  ),
                ),
                //Icon(Icons.edit,color: Color(0xFF609f38)),
              ),
              Divider(color: Colors.black38,),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      width: 1.2,
                      color: Color(0xFF609f38),
                    ),
                  ),
                  child: Icon(Icons.date_range,color: Color(0xFF609f38),size: 24),
                ),
                title: Text('Joining Date',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                subtitle: Text(userData['joiningDate'],style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal)),
              ),
              Divider(color: Colors.black38,),
              ListTile(
                leading: Container(
                  //margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      width: 1.2,
                      color: Color(0xFF609f38),
                    ),
                  ),
                  child: Icon(Icons.location_on,color: Color(0xFF609f38),size: 24),
                ),
                title: Text('Address',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                subtitle: Text(userData['city'],style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal)),
              ),
              Divider(color: Colors.black38,),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}