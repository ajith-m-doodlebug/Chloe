import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';

import 'Expenditure/expenditureSet.dart';
import 'Head/head.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Head(),
              Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Text(
                  'Expenditure',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 15.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
                child: Divider(
                  color: kWhite,
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ExpenditureSet(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
