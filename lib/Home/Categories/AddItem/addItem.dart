import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';

import 'addItemForm.dart';

class AddItem extends StatefulWidget {
  final String category;
  AddItem({required this.category});

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kWhite,
          ),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        title: Text(
          'Add Item',
          style: TextStyle(color: kWhite),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          AddItemForm(category: widget.category),
        ],
      ),
    );
  }
}
