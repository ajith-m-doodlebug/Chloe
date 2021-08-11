import 'dart:convert';
import 'package:fin_tech_app/Classes/budgetClass.dart';
import 'package:fin_tech_app/Classes/itemsClass.dart';
import 'package:fin_tech_app/FinalStrings/categoryNames.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'budget.dart';

// LIST
setCatList({required String category, required Items one}) async {
  late List<Items> data = [];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  //get the list
  String? catListString = preferences.getString('${category}List');
  if (catListString != null) {
    var jsonObjects = jsonDecode(catListString) as List;
    data = jsonObjects.map((tagJson) => Items.fromJson(tagJson)).toList();
  }
  //add to the list
  data.add(one);
  String jsonTags = jsonEncode(data);
  //store in LS
  await preferences.setString('${category}List', jsonTags);
}

getCatList({required String category}) async {
  late List<Items> data = [];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  //get the list
  String? catListString = preferences.getString('${category}List');
  if (catListString != null) {
    var jsonObjects = jsonDecode(catListString) as List;
    data = jsonObjects.map((tagJson) => Items.fromJson(tagJson)).toList();
  }
  return data;
}

// TO GH LIST

sendListToGH({required String userID, required String category}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? catListString = preferences.getString('${category}List');
  print(catListString);
  String soop1 = catListString!.replaceAll("[", "");
  String soop2 = soop1.replaceAll("]", "");
  print(soop2);
  var response = await http.get(Uri.parse(
      'https://budget-boom.herokuapp.com/ProjectBudget/put/$userID/$category/$soop2'));
  print(response.body);
}

getListFromGH({required String userID}) {
  late List<Items> data = [];
  var soop;
  var response = http.get(
      Uri.parse('https://budget-boom.herokuapp.com/ProjectBudget/get/$userID'));
  response.then((value) async {
    soop = value.body.replaceAll("'", "");
    print(soop);
    var tagObjsJson = jsonDecode(soop) as List;
    List<Items> data =
        tagObjsJson.map((tagJson) => Items.fromJson(tagJson)).toList();
    print(data[0].category);
    //
    late Budget budget;
    budget = await getBudget();
    for (Items co in data) {
      setCatList(category: co.category, one: co);
      setCatTotal(category: co.category, one: co.price);
      budget.remainingBudget = budget.remainingBudget - co.price;
      budget.spendBudget = budget.spendBudget + co.price;
      await setBudget(one: budget);
    }
  });
}

removeCatList({required String category}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove('${category}List');
}

removeAllCatList() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove('${generalCategory}List');
  await preferences.remove('${transportCategory}List');
  await preferences.remove('${shoppingCategory}List');
  await preferences.remove('${billsCategory}List');
  await preferences.remove('${entertainmentCategory}List');
  await preferences.remove('${groceryCategory}List');
}

// TOTAL

setCatTotal({required String category, required double one}) async {
  double oldTotal = 0.0;
  late double newTotal;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  //get the num
  String? catTotalString = preferences.getString('${category}Total');
  if (catTotalString != null) {
    oldTotal = double.parse(catTotalString);
  }
  //add to the total
  newTotal = oldTotal + one;
  //store in LS
  await preferences.setString('${category}Total', newTotal.toString());
}

getCatTotal({required String category}) async {
  double total = 0.0;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  //get the num
  String? catListString = preferences.getString('${category}Total');
  if (catListString != null) {
    total = double.parse(catListString);
  }
  return total;
}

removeCatTotal({required String category}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove('${category}Total');
}

removeAllCatTotal() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove('${generalCategory}Total');
  await preferences.remove('${transportCategory}Total');
  await preferences.remove('${shoppingCategory}Total');
  await preferences.remove('${billsCategory}Total');
  await preferences.remove('${entertainmentCategory}Total');
  await preferences.remove('${groceryCategory}Total');
}
