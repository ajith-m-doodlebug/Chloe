import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';

import 'expenditureDisplaySet.dart';

class ExpenditureDisplay extends StatefulWidget {
  final String text;
  final Color color;
  final String category;

  ExpenditureDisplay({
    required this.text,
    required this.color,
    required this.category,
  });
  @override
  _ExpenditureDisplayState createState() => _ExpenditureDisplayState();
}

class _ExpenditureDisplayState extends State<ExpenditureDisplay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            'Expenditure',
            style: TextStyle(color: kWhite),
          ),
          centerTitle: true,
        ),
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
                      widget.text,
                      style: TextStyle(fontSize: 30.0, color: widget.color),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ExpenditureSet(
                      category: widget.category,
                    ),
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
