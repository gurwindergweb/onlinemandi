import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
        'images/online-logo1.png',
        width: 90,
        height: 90,
        fit: BoxFit.cover,
      ),
      ),
    );
  }
}
