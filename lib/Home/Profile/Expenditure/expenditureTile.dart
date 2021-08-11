import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/Home/Profile/Expenditure/subExpenditureTile.dart';
import 'package:fin_tech_app/Home/Profile/ExpenditureDisplay/expenditureDisplay.dart';
import 'package:fin_tech_app/PageTransition/rightSlide.dart';
import 'package:flutter/material.dart';
import 'package:fin_tech_app/LocalStorage/budget.dart';
import 'package:fin_tech_app/LocalStorage/categoriesGeneral.dart';
import 'package:fin_tech_app/Classes/budgetClass.dart';

class ExpenditureTile extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color color;
  final String category;

  ExpenditureTile({
    required this.text,
    required this.icon,
    required this.color,
    required this.category,
  });

  @override
  _ExpenditureTileState createState() => _ExpenditureTileState();
}

class _ExpenditureTileState extends State<ExpenditureTile> {
  late Budget budget = Budget(
    totalBudget: 0.0,
    spendBudget: 0.0,
    remainingBudget: 0.0,
    limit: 0.0,
  );
  late double total = 0.0;
  double spentPercentage = 0.0;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    double gotTotal = await getCatTotal(category: widget.category);
    setState(() {
      total = gotTotal;
    });
    Budget budget1 = await getBudget();
    setState(() {
      budget = budget1;
    });
    if (budget.spendBudget != 0 && budget.totalBudget != 0) {
      setState(() {
        spentPercentage = (total / budget.totalBudget) * 100;
      });
    }
    print('this is total $total');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: backgroundColor,
        highlightColor: backgroundColor,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onTap: () {
          Navigator.push(
            context,
            RightSlide(
              page: ExpenditureDisplay(
                text: widget.text,
                color: widget.color,
                category: widget.category,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Ink(
            height: 60.0,
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubExpenditureTile(
                  text: widget.text,
                  icon: widget.icon,
                  color: widget.color,
                  total: total,
                ),
                Text(
                  '${spentPercentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: kWhite,
                width: 0.5,
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
        ),
      ),
    );
  }
}
