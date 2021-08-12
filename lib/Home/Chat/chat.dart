import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'chatMessageArea.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Container(
              width: width,
              color: mainColor,
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Center(
                child: Text(
                  'Chloe 😃',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ChatMessageArea(),
            ),
          ],
        ),
      ),
    );
  }
}
