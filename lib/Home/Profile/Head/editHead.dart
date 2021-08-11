import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/LocalStorage/budget.dart';
import 'package:fin_tech_app/LocalStorage/categoriesGeneral.dart';
import 'package:fin_tech_app/LocalStorage/landingPage.dart';
import 'package:fin_tech_app/LocalStorage/userData.dart';
import 'package:fin_tech_app/OnBoarding/welcome.dart';
import 'package:fin_tech_app/PageTransition/rightSlide.dart';
import 'package:flutter/material.dart';
import 'editHeadForm.dart';

class EditHead extends StatefulWidget {
  @override
  _EditHeadState createState() => _EditHeadState();
}

class _EditHeadState extends State<EditHead> {
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
          'Edit Budget',
          style: TextStyle(color: kWhite),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              removeUserData();
              removeAllCatList();
              removeAllCatTotal();
              removeBudget();
              setWelcomeLandingPage();
              Navigator.pushAndRemoveUntil(
                  context, RightSlide(page: Welcome()), (route) => false);
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: EditHeadForm(),
      ),
    );
  }
}
