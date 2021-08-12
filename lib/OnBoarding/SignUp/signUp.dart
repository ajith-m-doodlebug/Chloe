import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/OnBoarding/SignUp/SignUpForm.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kWhite,
          ),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
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
              height: 100.0,
              width: 200.0,
              child: Center(
                  child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 50.0, color: mainColor),
              )),
            ),
            SignUpForm(),
            //bottom
          ],
        ),
      ),
    );
  }
}
