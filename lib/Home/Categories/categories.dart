import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'categoriesSet.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(fontSize: 30.0, color: mainColor),
                    ),
                    Text(
                      'Classify the expenditure into a particular category.',
                      style: TextStyle(fontSize: 15.0, color: kWhite),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CategoriesSet(),
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
