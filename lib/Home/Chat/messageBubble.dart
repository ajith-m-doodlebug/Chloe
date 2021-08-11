import 'package:fin_tech_app/Classes/message.dart';
import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/FinalStrings/chatNames.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final Message message;
  MessageBubble({required this.message});

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  late bool isHumanUser;

  @override
  void initState() {
    check();
    super.initState();
  }

  check() {
    if (widget.message.sender == humanUser) {
      setState(() {
        isHumanUser = true;
      });
    } else if (widget.message.sender == chatBot) {
      setState(() {
        isHumanUser = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isHumanUser
        ? Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.70,
              ),
              child: Container(
                child: Text(
                  widget.message.msg,
                  style: TextStyle(color: kWhite, fontSize: 16.0),
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0.0),
                    topLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.70,
              ),
              child: Container(
                child: Text(
                  widget.message.msg,
                  style: TextStyle(color: kWhite, fontSize: 16.0),
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
