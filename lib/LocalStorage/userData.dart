import 'dart:convert';
import 'package:fin_tech_app/Classes/budgetClass.dart';
import 'package:fin_tech_app/Classes/userClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'budget.dart';
import 'categoriesGeneral.dart';

setUserDataLogIn({userID}) async {
  SharedPreferences userDetail = await SharedPreferences.getInstance();
  var value = await usersInstance.doc(userID).get();
  if (value.data()!.isNotEmpty) {
    print(value.data()!['budget']);
    print(value.data()!['budget'].toString());
    var one = UserClass(
      name: value.data()!['name'] ?? '',
      email: value.data()!['email'] ?? '',
      password: value.data()!['password'] ?? '',
      userID: userID,
      budget: double.parse(value.data()!['budget'].toString()),
      remaining: double.parse(value.data()!['remaining'].toString()),
      limit: double.parse(value.data()!['limit'].toString()),
    );
    var two = Budget(
        totalBudget: one.budget,
        spendBudget: 0.0,
        remainingBudget: one.budget,
        limit: one.limit);
    await setBudget(one: two);
    String jsonTags = jsonEncode(one);
    await userDetail.setString("UserData", jsonTags);
    await getListFromGH(userID: userID);
  }
}

setUserDataSignUp(
    {name, email, password, userID, budget, remaining, limit}) async {
  SharedPreferences userDetail = await SharedPreferences.getInstance();
  var one = UserClass(
    name: name,
    email: email,
    password: password,
    userID: userID,
    budget: budget,
    remaining: remaining,
    limit: limit,
  );
  String jsonTags = jsonEncode(one);
  await userDetail.setString("UserData", jsonTags);
}

getUserData() async {
  UserClass userData = UserClass(
    name: '',
    email: '',
    password: '',
    userID: '',
    budget: 0.0,
    remaining: 0.0,
    limit: 0.0,
  );
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? storeUserData = preferences.getString("UserData");
  Map<String, dynamic> userMap = jsonDecode(storeUserData!);
  userData = UserClass.fromJson(userMap);
  return userData;
}

removeUserData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove("UserData");
}
