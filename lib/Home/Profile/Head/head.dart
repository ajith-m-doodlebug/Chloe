import 'package:fin_tech_app/Classes/budgetClass.dart';
import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/LocalStorage/budget.dart';
import 'package:fin_tech_app/PageTransition/rightSlide.dart';
import 'package:flutter/material.dart';

import 'editHead.dart';

class Head extends StatefulWidget {
  @override
  _HeadState createState() => _HeadState();
}

class _HeadState extends State<Head> {
  late Budget budget = Budget(
    totalBudget: 0.0,
    spendBudget: 0.0,
    remainingBudget: 0.0,
    limit: 0.0,
  );

  double spentPercentage = 0.0;
  bool limitExceeded = false;
  bool budgetExceeded = false;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    Budget budget1 = await getBudget();
    setState(() {
      budget = budget1;
    });
    if (budget.spendBudget != 0 && budget.totalBudget != 0) {
      setState(() {
        spentPercentage = (budget.spendBudget / budget.totalBudget) * 100;
      });
    }
    if (budget.limit != 0 && spentPercentage > budget.limit) {
      setState(() {
        limitExceeded = true;
      });
    } else {
      setState(() {
        limitExceeded = false;
      });
    }
    if (budget.spendBudget > budget.totalBudget) {
      setState(() {
        budgetExceeded = true;
      });
    } else {
      setState(() {
        budgetExceeded = false;
      });
    }
    print('this is remain ${budget.remainingBudget}');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: backgroundColor,
      highlightColor: backgroundColor,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onTap: () {
        Navigator.push(
          context,
          RightSlide(
            page: EditHead(),
          ),
        ).then((value) {
          _getData();
        });
      },
      child: Ink(
        height: 170.0,
        width: width,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '₹ ${budget.spendBudget.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 50.0,
                    ),
                  ),
                  Text(
                    'You spent ${spentPercentage.toStringAsFixed(2)}% Budget',
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: kWhite,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Row(
                    children: [
                      Text(
                        '₹ ${budget.totalBudget.toStringAsFixed(2)}  ',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        'Budget',
                        style: TextStyle(
                          color: budgetExceeded ? errorColor : kWhite,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  child: VerticalDivider(
                    color: kWhite,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        '${budget.limit.toStringAsFixed(0)}%  ',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        'Limit',
                        style: TextStyle(
                          color: limitExceeded ? errorColor : kWhite,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: budgetExceeded || limitExceeded ? errorColor : mainColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
