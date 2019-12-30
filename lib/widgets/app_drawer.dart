import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlinemandi/screens/Term_conditions.dart';
import 'package:onlinemandi/screens/about_us.dart';
import 'package:onlinemandi/screens/mantines_mode.dart';
import 'package:onlinemandi/screens/my_account.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatefulWidget{
  @override
  AppDrawerState createState() => AppDrawerState();

}
class AppDrawerState extends State<AppDrawer> {
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
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Drawer(
      elevation: 10,
      child: Column(
        children: <Widget>[
          AppBar(
            leading: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                //margin: const EdgeInsets.only(left:0 ,right:10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(
                    color: Color(0xFFededdf),
                    width: 1.2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(1),
                  child:CircleAvatar(
                      backgroundImage: AssetImage(
                        'images/download.jpg',
                      ),
                      backgroundColor: Color(0xFFededdf),
                      radius: 80
                  ),
                ),
              ),
            ),
            //leading: Icon(Icons.person,color: Colors.white),
            title: Text(userData['username'] !=null ? userData['username'] : '' ,style: TextStyle(color: Color(0xFFededdf),fontWeight: FontWeight.bold,
              fontSize: ScreenUtil.getInstance().setSp(50),
            )),
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFF609f38),
          ),
          //Divider(),
          Expanded(
            child: _chatEnvironment(context),
          ),
        ],
      ),
    );
  }
}

Widget _chatEnvironment (context) {
  return IconTheme(
    data: new IconThemeData(color: Colors.blue),
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.home,color: Color(0xFF609f38)),
            trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
            title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: ScreenUtil.getInstance().setSp(40),
            )),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person,color: Color(0xFF609f38)),
            trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
            title: Text('My Account',style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: ScreenUtil.getInstance().setSp(40),
            )),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MyAccount.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.format_color_text,color: Color(0xFF609f38)),
            trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
            title: Text('About Us',style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: ScreenUtil.getInstance().setSp(40),
            )),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(About.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.pan_tool,color: Color(0xFF609f38)),
            trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
            title: Text('Term & Conditions',style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: ScreenUtil.getInstance().setSp(40),
            )),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(TermConditions.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app,color: Color(0xFF609f38)),
            trailing:Icon (Icons.keyboard_arrow_right,color: Color(0xFF609f38)),
            title: Text('Logout',style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: ScreenUtil.getInstance().setSp(40),
            )),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          Divider(),
        ],
      ),
    ),
  );
}