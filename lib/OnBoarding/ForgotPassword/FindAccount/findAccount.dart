import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'findAccountForm.dart';

class FindAccount extends StatefulWidget {
  @override
  _FindAccountState createState() => _FindAccountState();
}

class _FindAccountState extends State<FindAccount> {
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
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              height: 200.0,
              child: Center(
                  child: Text(
                'Find Account',
                style: TextStyle(fontSize: 50.0, color: mainColor),
              )),
            ),
            FindAccountForm(),
          ],
        ),
      ),
    );
  }
}
