import 'package:fin_tech_app/Classes/budgetClass.dart';
import 'package:fin_tech_app/Classes/userClass.dart';
import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/CreatedWidgets/inputField.dart';
import 'package:fin_tech_app/CreatedWidgets/longButton.dart';
import 'package:fin_tech_app/LocalStorage/budget.dart';
import 'package:fin_tech_app/LocalStorage/userData.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';

class EditHeadForm extends StatefulWidget {
  @override
  _EditHeadFormState createState() => _EditHeadFormState();
}

class _EditHeadFormState extends State<EditHeadForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _totalBudgetC = TextEditingController();
  late TextEditingController _limitC = TextEditingController();

  bool _loading = false;

  String buttonText = 'SET';
  bool buttonDisabled = false;

  late Budget budget;

  late UserClass userData;

  late String userID;

  @override
  void initState() {
    _getUserData();
    _getData();
    super.initState();
  }

  _getUserData() async {
    userData = await getUserData();
    setState(() {
      userID = userData.userID;
    });
    print('this is userID $userID');
  }

  _getData() async {
    Budget budget1 = await getBudget();
    setState(() {
      budget = budget1;
      _totalBudgetC =
          TextEditingController(text: budget.totalBudget.toString());
      _limitC = TextEditingController(text: budget.limit.toString());
    });
    print('this is remain ${budget.remainingBudget}');
  }

  _setData() async {
    budget.totalBudget = double.parse(_totalBudgetC.text);
    budget.remainingBudget =
        double.parse(_totalBudgetC.text) - budget.spendBudget;
    budget.limit = double.parse(_limitC.text);
    await setBudget(one: budget);
    await _updateData();
  }

  _updateData() async {
    usersInstance.doc(userID).update({
      'budget': double.parse(_totalBudgetC.text),
      'limit': double.parse(_limitC.text),
    });
  }

  _clearFields() {
    _totalBudgetC.clear();
    _limitC.clear();
  }

  @override
  void dispose() {
    super.dispose();
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
                  'Total Budget: ',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                width: 200.0,
                child: InputField(
                  controller: _totalBudgetC,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Budget can\'t be Zero';
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
                  'Limit (%): ',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                width: 200.0,
                child: InputField(
                  controller: _limitC,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a number';
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
                      await _setData();
                      await _clearFields();
                      setState(() {
                        _loading = false;
                      });
                      Navigator.pop(context);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
