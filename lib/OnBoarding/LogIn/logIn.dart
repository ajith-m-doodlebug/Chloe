import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'logInForm.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Text(
          'Chloe',
          style: TextStyle(color: kWhite),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              height: 200.0,
              width: 200.0,
              child: Center(
                  child: Text(
                'Log In',
                style: TextStyle(fontSize: 50.0, color: mainColor),
              )),
            ),
            LogInForm(),
          ],
        ),
      ),
    );
  }
}
