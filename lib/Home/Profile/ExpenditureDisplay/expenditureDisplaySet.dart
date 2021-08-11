import 'package:fin_tech_app/Classes/itemsClass.dart';
import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/LocalStorage/categoriesGeneral.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenditureSet extends StatefulWidget {
  final String category;

  ExpenditureSet({
    required this.category,
  });

  @override
  _ExpenditureSetState createState() => _ExpenditureSetState();
}

class _ExpenditureSetState extends State<ExpenditureSet> {
  List<Items> data = [];
  @override
  void initState() {
    _getData();
    super.initState();
  }

  final noExpenditure = SnackBar(
      content: Text(
    'No expenditure is done.',
    style: TextStyle(color: mainColor),
  ));

  _getData() async {
    List<Items> gotData = await getCatList(category: widget.category);
    setState(() {
      data = gotData;
    });
    if (data.isEmpty) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(noExpenditure);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, i) {
          return Cool(
            name: data[i].name,
            date: data[i].date,
            price: data[i].price,
          );
        },
      ),
    );
  }
}

class Cool extends StatefulWidget {
  final String name;
  final DateTime date;
  final double price;
  Cool({required this.name, required this.date, required this.price});

  @override
  _CoolState createState() => _CoolState();
}

class _CoolState extends State<Cool> {
  late String toDate;

  @override
  void initState() {
    getFormattedDate(date: widget.date);
    super.initState();
  }

  getFormattedDate({date}) async {
    var outputFormat = DateFormat('dd/MM/yyyy');
    setState(() {
      toDate = outputFormat.format(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(
                  color: kWhite,
                  fontSize: 20.0,
                ),
                overflow: TextOverflow.fade,
              ),
              Text(
                toDate,
                style: TextStyle(
                  color: kWhite,
                  fontSize: 12.0,
                ),
                overflow: TextOverflow.fade,
              ),
            ],
          ),
          Text(
            widget.price.toStringAsFixed(1),
            style: TextStyle(
              color: kWhite,
              fontSize: 20.0,
            ),
            overflow: TextOverflow.fade,
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
    );
  }
}
