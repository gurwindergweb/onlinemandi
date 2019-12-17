import 'dart:math';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../providers/auth.dart';
import '../models/http_exception.dart';
import 'forgot_password.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final authDataModel = Provider.of<Auth>(context);
    final states = authDataModel.states;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,

      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(200, 200, 255, 1).withOpacity(0.9),
                  Color.fromRGBO(153,255,153,2).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 6],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    //margin: EdgeInsets.only(bottom: 20.0),
                    padding: EdgeInsets.only(top: 25.0),
                    child:Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width:5.2,
                                color: Color(0xFF609f38),
                              ),
                              borderRadius: new BorderRadius.circular(100.0),
                            ),
                            //child: Icon(Icons.supervised_user_circle,size: 73,color: Colors.green),
                            child: Image.asset(
                              'images/online-logo.png',
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'OnlineMandi',
                            style: TextStyle(
                              //color: Color(0xff006600),
                              color:Color(0xFF609f38),
                              fontSize: 38,
                              fontFamily: 'Anton',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                 /* Flexible(
                    child: Container(
                      //margin: EdgeInsets.only(bottom: 20.0),
                      padding: EdgeInsets.only(top: 25.0),
                      child:Container(
                        child: Column(
                          children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width:5.2,
                                    color: Color(0xFF609f38),
                                  ),
                                  borderRadius: new BorderRadius.circular(100.0),
                                ),
                                //child: Icon(Icons.supervised_user_circle,size: 73,color: Colors.green),
                                child: Image.asset(
                                  'images/online-logo.png',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                'OnlineMandi',
                                style: TextStyle(
                                  //color: Color(0xff006600),
                                  color:Color(0xFF609f38),
                                  fontSize: 38,
                                  fontFamily: 'Anton',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),*/
                  Flexible(
                    //flex: deviceSize.width > 600 ? 0 : 3,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  var _isInit = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> _formKeyRegister = GlobalKey();
  List<DropdownMenuItem<int>> stateList = [];
  List<DropdownMenuItem<String>> cityList = [];
  List<DropdownModel>_cities = [];

  String dropdownValue;
  @override
  void initState() {
    super.initState();
  }
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _stateFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _repasswordFocusNode = FocusNode();
  Map<String, String> _authRegisterData = {
    'name': '',
    'phone': '',
    'state': null,
    'city': null,
    'email': '',
    'password': '',
    'repassword': '',
  };
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      print("loadding statesssssssssss");
      final authData = Provider.of<Auth>(context, listen: false);
      authData.getStates().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
   loadStateList() {
    stateList = [];
    cityList = [];
    final authData = Provider.of<Auth>(context, listen: false);

    return authData.states.map<DropdownMenuItem<String>>((DropdownModel item) {
      return DropdownMenuItem<String>(
        value: item.id.toString(),
        child: Text(item.name),
      );
    }).toList();
  }
  loadCityList(int entity) {
    setState(() {
      _isLoading = false;
    });
    _authRegisterData['city'] = null;
    final authData = Provider.of<Auth>(context, listen: false);
    _isLoading = true;
    authData.getCities(entity).then((_) {
      _cities.length = 0;
      _cities = authData.cities;
        setState(() {
          _isLoading = false;
        });
    });
  }
  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if(value.length != 10){
      return "Mobile number must be 10 digits long";
    }else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }





  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
    );
  }
  Future<void> _register() async {
    if (!_formKeyRegister.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKeyRegister.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      print('qwer');
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authRegisterData['name'],
          _authRegisterData['email'],
          _authRegisterData['phone'],
          _authRegisterData['city'],
          _authRegisterData['password'],
        );
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });








  }
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
        print("passed");
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      print(error);
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    loadStateList();
    return  Container(

      child: Container(
        width: deviceSize.width * 0.85,
        //padding: const EdgeInsets.all(10.0),
        child: _authMode == AuthMode.Login ? formLogin(): formRegister(),

        //height: _authMode == AuthMode.Signup ? 1000 : 260,
        //constraints:
            //BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 1000 : 260),
        //width: deviceSize.width * 0.85,
        //padding: EdgeInsets.all(16.0),
       ),
    );
  }


  Widget formRegister(){
    return Form(
      key: _formKeyRegister,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_emailFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please provide your name.';
                }
                return null;
              },
              onSaved: (value) {
                _authRegisterData['name'] = value;
              },
              style: new TextStyle(color: Colors.black),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'E-Mail'),
              focusNode: _emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_phoneFocusNode);
              },
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Invalid email!';
                }
                return null;
              // ignore: missing_return
              },
              onSaved: (value) {
                _authRegisterData['email'] = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Mobile number'),
              keyboardType: TextInputType.phone,
              focusNode: _phoneFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_stateFocusNode);
              },
              validator: (value) {
                return validateMobile(value);
              },
              onSaved: (value) {
                _authRegisterData['phone'] = value;
              },
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            DropdownButton<String>(
              value: _authRegisterData['state'],
              hint: new Text('Select state',style: TextStyle(fontSize: 16)),
              isExpanded: true,
              //style: TextStyle(color: Colors.black),
              underline: Container(
                height: 1,
                color: Colors.black38,
              ),
              onChanged: (String newValue) {
                  _authRegisterData['state'] = newValue;
                  loadCityList(int.parse(newValue));
                  FocusScope.of(context).requestFocus(_stateFocusNode);
              },
              items: loadStateList(),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0,2,0,0)),
            DropdownButton<String>(
              hint: Text('Select city'),
              value: _authRegisterData['city'],
              isExpanded: true,
             // icon: Icons.arrow_drop_down_circle,
              underline: Container(
                height: 1,
                color: Colors.black38,
              ),
              onChanged: (String newValue) {
                setState(() {
                  _authRegisterData['city'] = newValue;
                });
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              items: _cities.map<DropdownMenuItem<String>>((DropdownModel item) {
                return DropdownMenuItem<String>(
                  value: item.id.toString(),
                  child: Text(item.name),
                );
              }).toList(),
            ),

            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              focusNode: _passwordFocusNode,
              controller: _passwordController,
              validator: (value) {
                if (value.isEmpty || value.length < 5) {
                  return 'Password is too short!';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_repasswordFocusNode);
              },
              onSaved: (value) {
                _authRegisterData['password'] = value;
              },
            ),
            TextFormField(
              enabled: true,
              focusNode: _repasswordFocusNode,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              validator: (value) {
                if (value != _passwordController.text) {
                  return 'Passwords do not match!';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            if (_isLoading)
              CircularProgressIndicator()
            else
             Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child:
                  Text('SIGN UP',style: TextStyle(fontSize:18,color: Colors.white,fontWeight: FontWeight.bold)),
                  onPressed: _register,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  color: Color(0xFF609f38),
                  textColor: Colors.white,
                  elevation: 0.9,
                ),
              ),
             FlatButton(
                child: Text('LOGIN INSTEAD'),
                onPressed:  _switchAuthMode,
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
               //textColor: Color(0xff006600),
               textColor: Color(0xff006600),
             ),
          ],
        ),
      ),
    );

  }


  Widget formLogin(){
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'E-Mail'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Invalid email!';
                }
              },
              onSaved: (value) {
                _authData['email'] = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              controller: _passwordController,
              validator: (value) {
                if (value.isEmpty || value.length < 5) {
                  return 'Password is too short!';
                }
              },
              onSaved: (value) {
                _authData['password'] = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            if (_isLoading)
              CircularProgressIndicator()
            else
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child:
                  Text('LOGIN',style: TextStyle(fontSize:18,color: Colors.white,fontWeight: FontWeight.bold)),
                  onPressed: _submit,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  //color: Color(0xff006600),
                  //color: Color.fromRGBO(204, 204, 255, 1),
                  color: Color(0xFF609f38),
                  textColor: Theme.of(context).primaryTextTheme.button.color,
                  elevation: 0.9,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
               /* FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed:_switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Color(0xff006600),
                ),*/
                InkWell(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD', style: TextStyle(color: Color(0xff006600), fontWeight: FontWeight.bold)),
                  onTap: _switchAuthMode,
                ),
                InkWell(
                  child: Text(
                      'Forgot Password',style: TextStyle(color: Color(0xff006600), fontWeight: FontWeight.bold)),
                  onTap: (){
                    Navigator.of(context).pushNamed(ForgotPassword.routeName);
                  },
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
