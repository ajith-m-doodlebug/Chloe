import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';

class TypeMessageBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onPressed;
  TypeMessageBox({required this.controller, required this.onPressed});

  @override
  _TypeMessageBoxState createState() => _TypeMessageBoxState();
}

class _TypeMessageBoxState extends State<TypeMessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
      height: 60.0,
      color: cardColor.withOpacity(0.60),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              keyboardType: TextInputType.text,
              cursorColor: kWhite,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(color: kWhite),
              decoration: InputDecoration(
                hintText: 'Send a message..',
                hintStyle: TextStyle(color: kHintTextColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kWhite, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kWhite, width: 1.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: mainColor,
            onPressed: widget.onPressed,
          ),
        ],
      ),
    );
  }
}
