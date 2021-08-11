import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';

import 'confirmAccountForm.dart';

class ConfirmAccount extends StatefulWidget {
  final String name;
  final String email;
  final String userID;

  ConfirmAccount({
    required this.name,
    required this.email,
    required this.userID,
  });
  @override
  _ConfirmAccountState createState() => _ConfirmAccountState();
}

class _ConfirmAccountState extends State<ConfirmAccount> {
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
                'Confirm Account',
                style: TextStyle(fontSize: 50.0, color: mainColor),
              )),
            ),
            ConfirmAccountForm(
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
