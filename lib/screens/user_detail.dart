import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:onlinemandi/providers/Utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
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
  var contact1 = TextEditingController();
  var contact2 = TextEditingController();
  var loading = false;
  @override
  void initState() {
    getuserdetail();
  }
  getuserdetail() async {
     prefs = await SharedPreferences.getInstance();
     resp = prefs.get('userData');
     setState(() {
       userData = json.decode(resp);
       this.contact1.text = userData['contact1'];
       this.contact2.text = userData['contact2'];
     });
  }
  editnumber(){
    smsOTPDialog(context).then((val){

    });
  }
  updatenumbers(){
    setState(() {
      loading = true;
    });
    var utilities = Utilities(userData['token'],userData['userId']);
    utilities.changenumber(this.contact1.text, this.contact2.text).then((resp) async {
      if(resp == 'success'){
        await Fluttertoast.showToast(
            msg: "Contact numbers updated successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: ScreenUtil.getInstance().setSp(45),
        ).then((val){
          setState(() {
            loading = false;
          });
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed('/');
        });
      }
      else{
        await Fluttertoast.showToast(
            msg: "Something went wrong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          fontSize: ScreenUtil.getInstance().setSp(45),
        ).then((val){
          setState(() {
            loading = false;
          });
        });
      }
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
                Padding(padding: EdgeInsets.fromLTRB(0,5,0,10)),
                Text('Change Contact Number!',style: TextStyle(color:Color.fromRGBO(76,165,13 ,1),fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(50))),
              ],
            ),
            content: loading == 'true'? CircularProgressIndicator(): Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Mobile Number 1',style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(50),fontWeight: FontWeight.bold)),
                TextField(
                  keyboardType :
                  TextInputType.number,
                  maxLength: 10,
                  controller: contact1,style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(45)),
                ),
                Text('Mobile Number 2',style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(50),fontWeight: FontWeight.bold)),
                TextField(
                  keyboardType :
                  TextInputType.number,
                  maxLength: 10,
                  controller: contact2,style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(45)),
                ),
              ],
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              MaterialButton(
                elevation: 10.0,
                padding: EdgeInsets.all(10),
                colorBrightness: Brightness.dark,
                color: new Color(0xFF609f38),
                shape: RoundedRectangleBorder(side: BorderSide(
                    color: Colors.white30,
                    width: 1.3,
                    style: BorderStyle.solid
                ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text( 'Update',style: TextStyle(color: Colors.white,fontSize: ScreenUtil.getInstance().setSp(45))),
                onPressed: updatenumbers,
              ),
              MaterialButton(
                elevation: 10.0,
                colorBrightness: Brightness.dark,
                color: Colors.red,
                shape: RoundedRectangleBorder(side: BorderSide(
                    color: Colors.white30,
                    width: 1.3,
                    style: BorderStyle.solid
                ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text( 'Cancel',style: TextStyle(color: Colors.white,fontSize: ScreenUtil.getInstance().setSp(45))),
                onPressed: (){
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    ScreenUtil.instance = ScreenUtil()..init(context);
    //getuserdetail();
   print(userData);
    return Scaffold(
      appBar: AppBar(
          title: Text('Profile',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(60))),
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
      body:  SingleChildScrollView(
        /*decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(204, 255, 255, 1).withOpacity(0.9),
              Color.fromRGBO(153,153,102,1).withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 6],
          ),
        ),*/
        child:  _profile(),
      ),
     );
  }

  Widget _profile () {
    print(userData);
    return IconTheme(
      data: new IconThemeData(color: Colors.blue),
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
              title: Text(userData['username'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(55))),
              subtitle: Text(userData['email'],style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal,fontSize: ScreenUtil.getInstance().setSp(50))),
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
              title: Text('Phone Number.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(55))),
              subtitle: Text(userData['contact1'] !='' ? userData['contact2']!='' ? userData['contact1']+', '+ userData['contact2'] : userData['contact1']  : '' ,style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal,fontSize: ScreenUtil.getInstance().setSp(45))),
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
              title: Text('Joining Date',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(55))),
              subtitle: Text(userData['joiningDate'],style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal,fontSize: ScreenUtil.getInstance().setSp(45))),
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
              title: Text('Address',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil.getInstance().setSp(55))),
              subtitle: Text(userData['city'],style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal,fontSize: ScreenUtil.getInstance().setSp(45))),
            ),
            Divider(color: Colors.black38,),
          ],
        ),
    );
  }
}
