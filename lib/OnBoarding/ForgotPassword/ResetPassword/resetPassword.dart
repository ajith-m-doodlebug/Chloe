import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/OnBoarding/ForgotPassword/ResetPassword/resetPasswordForm.dart';
import 'package:flutter/material.dart';

class ResetAccount extends StatefulWidget {
  final String name;
  final String email;
  final String userID;

  ResetAccount({
    required this.name,
    required this.email,
    required this.userID,
  });
  @override
  _ResetAccountState createState() => _ResetAccountState();
}

class _ResetAccountState extends State<ResetAccount> {
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
          'Budget',
          style: TextStyle(color: kWhite),
        ),
        centerTitle: true,
      ),
      //body
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              height: 200.0,
              child: Center(
                  child: Text(
                'Reset Password',
                style: TextStyle(fontSize: 50.0, color: mainColor),
              )),
            ),
            ResetPasswordForm(
              name: widget.name,
              email: widget.email,
              userID: widget.userID,
            ),
          ],
        ),
      ),
    );
  }
}
