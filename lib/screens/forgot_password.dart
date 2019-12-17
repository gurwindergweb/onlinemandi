import 'package:flutter/material.dart';
class ForgotPassword extends StatefulWidget{
  static var routeName = '/forgotPassword';
  @override
  State<ForgotPassword> createState() => ForgotPasswordState();
}
class ForgotPasswordState extends State<ForgotPassword>{
  var email = TextEditingController();
  var otp = TextEditingController();
  var npassword = TextEditingController();
  var cpassword = TextEditingController();
  var changestatus = 0;
  var loading = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF609f38),
          centerTitle: true,
          leading: InkWell(
            child: Icon(Icons.arrow_back,color: Colors.white,),
            onTap: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text('Forgot Password',style: TextStyle(color: Colors.white),),
        ),
        body: loading != true ? Center(
          child: changestatus == 0 ? Form(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
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
                  Text('Recover Password with',style: TextStyle(color:Color.fromRGBO(76,165,13 ,1),fontWeight: FontWeight.bold,fontSize: 18)),
                  Padding(padding: EdgeInsets.fromLTRB(0,5,0,5)),

                  /*TextFormField(
                    decoration: InputDecoration(labelText: 'Email', hintText:'',
                      labelStyle: new TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      //hintStyle: TextStyle(fontSize:15.0,color:Colors.black),
                    ),
                    style: new TextStyle(color: Colors.black),
                    keyboardType :
                    TextInputType.emailAddress,
                    controller: email,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a email';
                      }
                    },
                    onSaved: (String inValue) {
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20,bottom: 20),
                    child: MaterialButton(
                      elevation: 10,
                      minWidth: 400.0,
                      height: 50.0,
                      colorBrightness: Brightness.dark,
                      color: Color(0xFF609f38),
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.white,
                          width: 1.3,
                          style: BorderStyle.solid
                      ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text("Mobile",style: new TextStyle(
                        fontSize:20,
                        fontFamily: 'Montserrat-Regular',
                      ),
                      ),
                      onPressed:  (){
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0,5,0,5)),
                  Text('Or',style: TextStyle(color:Color.fromRGBO(76,165,13 ,1),fontSize: 18)),
                  Container(
                    padding: const EdgeInsets.only(top: 20,bottom: 20),
                    child: MaterialButton(
                      elevation: 10,
                      minWidth: 400.0,
                      height: 50.0,
                      colorBrightness: Brightness.dark,
                      color: Color(0xFF609f38),
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.white,
                          width: 1.3,
                          style: BorderStyle.solid
                      ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text("Email",style: new TextStyle(
                        fontSize:20,
                        fontFamily: 'Montserrat-Regular',
                      ),
                      ),
                      onPressed:  (){
                      },
                    ),
                  ),*/
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(1),
                            height:80,
                            width:80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              color: Color.fromRGBO(76,165,13 ,1),
                            ),
                            child: Icon(Icons.sms,color: Colors.white,size: 30),
                          ),
                          onTap: (){

                          },
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text('Or'),
                        Padding(padding: EdgeInsets.all(10)),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(1),
                            height:80,
                            width:80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              color: Color.fromRGBO(76,165,13 ,1),
                            ),
                            child: Icon(Icons.email,color: Colors.white,size: 30),
                          ),
                          onTap: (){

                          },
                        ),
                      ],
                    ),


                ],
              ),
            ),
          ) : Form(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(27,15,27,0),
              child: Column(
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
                    child: Icon(Icons.mail,color: Color.fromRGBO(76,165,13 ,1),size:62),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0,5,0,5)),
                  Text('Enter Your OTP',style: TextStyle(color:Color.fromRGBO(76,165,13 ,1),fontWeight: FontWeight.bold,fontSize: 18)),
                  Padding(padding: EdgeInsets.fromLTRB(0,5,0,5)),
                  //Text('Please enter your new password',style: TextStyle(color:Colors.black,fontWeight: FontWeight.normal,fontSize: 14)),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Verify OTP', hintText:'',
                      labelStyle: new TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintStyle: TextStyle(fontSize:15.0,color:Colors.black),
                    ),
                    style: new TextStyle(color: Colors.black),
                    keyboardType :
                    TextInputType.emailAddress,
                    controller: otp,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Otp';
                      }
                    },
                    onSaved: (String inValue) {
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'New Password', hintText:'',
                      labelStyle: new TextStyle(color: Colors.black),

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintStyle: TextStyle(fontSize:15.0,color:Colors.black),
                    ),
                    style: new TextStyle(color: Colors.black),
                    keyboardType :
                    TextInputType.emailAddress,
                    obscureText : true,
                    controller: npassword,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter new password';
                      }
                    },
                    onSaved: (String inValue) {
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Confirm Password', hintText:'',
                      labelStyle: new TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintStyle: TextStyle(fontSize:15.0,color:Colors.black),
                    ),
                    style: new TextStyle(color: Colors.black),
                    keyboardType :
                    TextInputType.emailAddress,
                    controller: cpassword,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Re-enter new password';
                      }
                    },
                    onSaved: (String inValue) {
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    child: MaterialButton(
                      elevation: 5.0,
                      minWidth: 400.0,
                      height: 50.0,
                      colorBrightness: Brightness.dark,
                      color: new Color(0xFFFDB60C),
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.white,
                          width: 1.3,
                          style: BorderStyle.solid
                      ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text("verify",style: new TextStyle(
                        fontSize:20,
                        fontFamily: 'Montserrat-Regular',
                      ),
                      ),
                      onPressed:  (){

                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ) : Center(child: CircularProgressIndicator(),)
    );
  }

}