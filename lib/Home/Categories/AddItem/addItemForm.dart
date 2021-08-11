import 'package:fin_tech_app/Classes/budgetClass.dart';
import 'package:fin_tech_app/Classes/itemsClass.dart';
import 'package:fin_tech_app/Classes/userClass.dart';
import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/CreatedWidgets/inputField.dart';
import 'package:fin_tech_app/CreatedWidgets/longButton.dart';
import 'package:fin_tech_app/LocalStorage/budget.dart';
import 'package:fin_tech_app/LocalStorage/categoriesGeneral.dart';
import 'package:fin_tech_app/LocalStorage/userData.dart';
import 'package:flutter/material.dart';

class AddItemForm extends StatefulWidget {
  final String category;
  AddItemForm({required this.category});
  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameC = TextEditingController();
  final _itemPriceC = TextEditingController();

  bool _loading = false;

  List<Items> data = [];

  String buttonText = 'ADD';
  bool buttonDisabled = false;

  late UserClass userData;

  late String userID;

  late Budget budget;

  double spentPercentage = 0.0;
  bool limitExceeded = false;

  @override
  void initState() {
    print(widget.category);
    _getUserData();
    super.initState();
  }

  final totalBudgetZero = SnackBar(
      content: Text(
    'First set a budget before adding expenditure.',
    style: TextStyle(color: mainColor),
  ));

  final remainingBudgetZero = SnackBar(
      content: Text(
    'Increase the budget before adding expenditure.',
    style: TextStyle(color: mainColor),
  ));

  final limitOver = SnackBar(
      content: Text(
    'Your expenditure limit is over.',
    style: TextStyle(color: mainColor),
  ));

  _getUserData() async {
    userData = await getUserData();
    setState(() {
      userID = userData.userID;
    });
    print('this is userID ${userData.name}');
    budget = await getBudget();
    if (budget.spendBudget != 0 && budget.totalBudget != 0) {
      setState(() {
        spentPercentage = (budget.spendBudget / budget.totalBudget) * 100;
      });
    }
    if (budget.totalBudget == 0.0) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(totalBudgetZero);
    } else if (budget.remainingBudget <= 0.0) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(remainingBudgetZero);
    } else if (budget.limit != 0 && spentPercentage > budget.limit) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(limitOver);
    }
  }

  _addData() async {
    final DateTime nowTime = DateTime.now();
    Items one = Items(
      category: widget.category,
      name: _itemNameC.text,
      price: double.parse(_itemPriceC.text),
      date: nowTime,
    );
    await setCatList(category: widget.category, one: one);
    await setCatTotal(
        category: widget.category,
        one: double.parse(_itemPriceC.text.toString()));
    budget = await getBudget();
    budget.remainingBudget =
        budget.remainingBudget - double.parse(_itemPriceC.text);
    budget.spendBudget = budget.spendBudget + double.parse(_itemPriceC.text);
    await setBudget(one: budget);
    await sendListToGH(userID: userID, category: widget.category);
  }

  _clearFields() {
    _itemNameC.clear();
    _itemPriceC.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Item Name: ',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                width: 200.0,
                child: InputField(
                  controller: _itemNameC,
                  hintText: 'Item Name',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the name';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Item Price: ',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                width: 200.0,
                child: InputField(
                  controller: _itemPriceC,
                  keyboardType: TextInputType.number,
                  hintText: 'Item Price',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          LongButton(
            text: buttonText,
            loading: _loading,
            onPressed: buttonDisabled
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      setState(() {
                        _loading = true;
                      });
                      await _addData();
                      await _clearFields();
                      setState(() {
                        _loading = false;
                      });
                    }
                  },
          ),
        ],
      ),
    );
  }
}
