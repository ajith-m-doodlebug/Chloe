import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/FinalStrings/categoryNames.dart';
import 'package:flutter/material.dart';

import 'categoriesTile.dart';

class CategoriesSet extends StatefulWidget {
  const CategoriesSet({Key? key}) : super(key: key);

  @override
  _CategoriesSetState createState() => _CategoriesSetState();
}

class _CategoriesSetState extends State<CategoriesSet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoriesTile(
                text: 'General',
                icon: Icons.widgets,
                color: cat1Color,
                category: generalCategory,
              ),
              CategoriesTile(
                text: 'Transport',
                icon: Icons.directions_bus,
                color: cat2Color,
                category: transportCategory,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoriesTile(
                text: 'Shopping',
                icon: Icons.shopping_bag,
                color: cat3Color,
                category: shoppingCategory,
              ),
              CategoriesTile(
                text: 'Bills',
                icon: Icons.margin,
                color: cat4Color,
                category: billsCategory,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoriesTile(
                text: 'Entertainment',
                icon: Icons.movie,
                color: cat5Color,
                category: entertainmentCategory,
              ),
              CategoriesTile(
                text: 'Grocery',
                icon: Icons.food_bank,
                color: cat6Color,
                category: groceryCategory,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
