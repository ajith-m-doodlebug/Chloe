import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/FinalStrings/categoryNames.dart';
import 'package:flutter/material.dart';

import 'expenditureTile.dart';

class ExpenditureSet extends StatefulWidget {
  @override
  _ExpenditureSetState createState() => _ExpenditureSetState();
}

class _ExpenditureSetState extends State<ExpenditureSet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpenditureTile(
          text: 'General',
          icon: Icons.widgets,
          color: cat1Color,
          category: generalCategory,
        ),
        ExpenditureTile(
          text: 'Transport',
          icon: Icons.directions_bus,
          color: cat2Color,
          category: transportCategory,
        ),
        ExpenditureTile(
          text: 'Shopping',
          icon: Icons.shopping_bag,
          color: cat3Color,
          category: shoppingCategory,
        ),
        ExpenditureTile(
          text: 'Bills',
          icon: Icons.margin,
          color: cat4Color,
          category: billsCategory,
        ),
        ExpenditureTile(
          text: 'Entertainment',
          icon: Icons.movie,
          color: cat5Color,
          category: entertainmentCategory,
        ),
        ExpenditureTile(
          text: 'Grocery',
          icon: Icons.food_bank,
          color: cat6Color,
          category: groceryCategory,
        ),
      ],
    );
  }
}
