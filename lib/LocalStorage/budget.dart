import 'package:fin_tech_app/Classes/budgetClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

setBudget({required Budget one}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String jsonTags = jsonEncode(one);
  await preferences.setString("Budget", jsonTags);
}

getBudget() async {
  Budget budget = Budget(
    totalBudget: 0.0,
    spendBudget: 0.0,
    remainingBudget: 0.0,
    limit: 0.0,
  );
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? budgetString = preferences.getString("Budget");
  if (budgetString != null) {
    Map<String, dynamic> userMap = jsonDecode(budgetString);
    budget = Budget.fromJson(userMap);
  }
  return budget;
}

removeBudget() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove("Budget");
}
