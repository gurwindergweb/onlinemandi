import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onlinemandi/providers/auth.dart';

class ForgotPassword extends StatefulWidget {
  static var routeName = '/forgotPassword';

  @override
  State<ForgotPassword> createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  var email = TextEditingController();
  var otp = TextEditingController();
  var npassword = TextEditingController();
  var cpassword = TextEditingController();
  var mobile = TextEditingController();
  var changestatus = 0;
  var loading = false;
  var auth = Auth();
  String displayform;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFF609f38),
            centerTitle: true,
            leading: InkWell(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Forgot Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: loading != true
              ? SingleChildScrollView(
            child: Center(
              child: changestatus == 0
                  ? Form(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(1),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                          border: Border.all(
                            color: Color.fromRGBO(76, 165, 13, 1),
                            width: 2.2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Icon(Icons.perm_phone_msg,
                            color: Color.fromRGBO(76, 165, 13, 1),
                            size: 62),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                      Text('Recover Password with',
                          style: TextStyle(
                              color: Color.fromRGBO(76, 165, 13, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.all(1),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50.0)),
                                color: Color.fromRGBO(76, 165, 13, 1),
                              ),
                              child: Icon(Icons.sms,
                                  color: Colors.white, size: 30),
                            ),
                            onTap: () {
                              setState(() {
                                displayform = 'sms';
                              });
                            },
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          Text('Or'),
                          Padding(padding: EdgeInsets.all(10)),
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.all(1),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50.0)),
                                color: Color.fromRGBO(76, 165, 13, 1),
                              ),
                              child: Icon(Icons.email,
                                  color: Colors.white, size: 30),
                            ),
                            onTap: () {
                              setState(() {
                                displayform = 'email';
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          displayform == "sms"
                              ? TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Mobile number',
                              hintText: '',
                              labelStyle: new TextStyle(
                                  color: Colors.black),
                              enabledBorder:
                              UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black),
                              ),
                              focusedBorder:
                              UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black),
                              ),
                              //hintStyle: TextStyle(fontSize:15.0,color:Colors.black),
                            ),
                            style: new TextStyle(
                                color: Colors.black),
                            keyboardType:
                            TextInputType.number,
                            controller: mobile,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a mobile number';
                              }
                            },
                          )
                              : displayform == "email"
                              ? TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: '',
                              labelStyle: new TextStyle(
                                  color: Colors.black),
                              enabledBorder:
                              UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black),
                              ),
                              focusedBorder:
                              UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black),
                              ),
                              //hintStyle: TextStyle(fontSize:15.0,color:Colors.black),
                            ),
                            style: new TextStyle(
                                color: Colors.black),
                            keyboardType:
                            TextInputType.emailAddress,
                            controller: email,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a email';
                              }
                            },
                            onSaved: (String inValue) {},
                          )
                              : Text(''),
                          displayform != null
                              ? Container(
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20),
                            child: MaterialButton(
                              elevation: 5.0,
                              minWidth: 400.0,
                              height: 50.0,
                              colorBrightness: Brightness.dark,
                              color: Color.fromRGBO(
                                  76, 165, 13, 1),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 1.3,
                                    style: BorderStyle.solid),
                                borderRadius:
                                BorderRadius.circular(50),
                              ),
                              child: Text(
                                "Send OTP",
                                style: new TextStyle(
                                  fontSize: 20,
                                  fontFamily:
                                  'Montserrat-Regular',
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                });
                                if (email.text.length >0) {
                                  auth
                                      .forgotpasswordrequest(
                                      email.text,'email')
                                      .then((res) {
                                    if (res ==
                                        'OTP sent successfully! Please check your email') {
                                      setState(() {
                                        changestatus = 1;
                                      });
                                      setState(() {
                                        loading = false;
                                      });
                                      Fluttertoast.showToast(
                                          msg: res,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIos: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                      Fluttertoast.showToast(
                                          msg: res,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIos: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  });
                                } else if (mobile.text.length >0) {
                                  auth
                                      .forgotpasswordrequest(
                                      mobile.text,'mobile')
                                      .then((res) {
                                    setState(() {
                                      loading = false;
                                    });
                                    if (res ==
                                        'OTP sent successfully') {
                                      setState(() {
                                        changestatus = 1;
                                      });

                                    } else {

                                    }
                                  });
                                } else {}
                              },
                            ),
                          )
                              : Text(''),
                        ],
                      )
                    ],
                  ),
                ),
              )
                  : Form(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(27, 15, 27, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(1),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                          border: Border.all(
                            color: Color.fromRGBO(76, 165, 13, 1),
                            width: 2.2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Icon(Icons.mail,
                            color: Color.fromRGBO(76, 165, 13, 1),
                            size: 62),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                      Text('Enter Your OTP',
                          style: TextStyle(
                              color: Color.fromRGBO(76, 165, 13, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                      //Text('Please enter your new password',style: TextStyle(color:Colors.black,fontWeight: FontWeight.normal,fontSize: 14)),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Verify OTP',
                          hintText: '',
                          labelStyle:
                          new TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black),
                          ),
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: Colors.black),
                        ),
                        style: new TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        controller: otp,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Otp';
                          }
                        },
                        onSaved: (String inValue) {},
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          hintText: '',
                          labelStyle:
                          new TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black),
                          ),
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: Colors.black),
                        ),
                        style: new TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        controller: npassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter new password';
                          }
                        },
                        onSaved: (String inValue) {},
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: '',
                          labelStyle:
                          new TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black),
                          ),
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: Colors.black),
                        ),
                        style: new TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        controller: cpassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Re-enter new password';
                          }
                        },
                        onSaved: (String inValue) {},
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: MaterialButton(
                          elevation: 5.0,
                          minWidth: 400.0,
                          height: 50.0,
                          colorBrightness: Brightness.dark,
                          color: Color(0xFF609f38),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.white,
                                width: 1.3,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "verify",
                            style: new TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat-Regular',
                            ),
                          ),
                          onPressed: () {
                            var to;
                            var method;
                            if(email.text != ''){
                              to = email.text;
                              method = 'email';
                            }
                            if(mobile.text != ''){
                              to = mobile.text;
                              method = 'mobile';
                            }
                            auth.changePassword(to, otp.text, npassword.text,method).then((res){
                              if(res == 'password changed success'){
                                Fluttertoast.showToast(
                                    msg: res,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                Navigator.of(context).pushReplacementNamed('/');
                              }
                              else{
                                Fluttertoast.showToast(
                                    msg: res,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
              : Center(
            child: CircularProgressIndicator(),
          )
      ),
    );
  }
}
