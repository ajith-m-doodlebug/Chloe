import 'package:fin_tech_app/Classes/budgetClass.dart';
import 'package:fin_tech_app/Classes/message.dart';
import 'package:fin_tech_app/FinalStrings/chatNames.dart';
import 'package:fin_tech_app/Home/Chat/typeMessageBox.dart';
import 'package:fin_tech_app/LocalStorage/budget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'messageBubble.dart';

class ChatMessageArea extends StatefulWidget {
  @override
  _ChatMessageAreaState createState() => _ChatMessageAreaState();
}

class _ChatMessageAreaState extends State<ChatMessageArea> {
  final TextEditingController _sendMessageC = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  List<Message> chats = [
    Message(
        sender: chatBot,
        msg: 'Hi, I am Chloe\n'
            'Ask me question like.....\n'
            'What is my expenditure?\n'
            'What is my balance?\n'
            'What is my budget?\n'
            'Limit?\n'),
  ];

  late Budget budget = Budget(
    totalBudget: 0.0,
    spendBudget: 0.0,
    remainingBudget: 0.0,
    limit: 0.0,
  );

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    Budget budget1 = await getBudget();
    setState(() {
      budget = budget1;
    });
  }

  getResponseFromBot({msg}) async {
    Message newMessage;
    var response = await http
        .get(Uri.parse('https://chatbot-chloe.herokuapp.com/get/$msg'));
    // check
    if (response.body == "1") {
      String edited = 'Your balance is ${budget.remainingBudget}';
      newMessage = Message(sender: chatBot, msg: edited);
    } else if (response.body == "2") {
      String edited = 'Your budget is ${budget.totalBudget}';
      newMessage = Message(sender: chatBot, msg: edited);
    } else if (response.body == "3") {
      String edited = 'Your expenditure is ${budget.spendBudget}';
      newMessage = Message(sender: chatBot, msg: edited);
    } else if (response.body == "4") {
      String edited =
          'Your Limit is set at ${budget.limit.toStringAsFixed(0)}%';
      newMessage = Message(sender: chatBot, msg: edited);
    } else {
      newMessage = Message(sender: chatBot, msg: response.body);
    }
    setState(() {
      chats.add(newMessage);
    });
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn);
    });
  }

  onMessageSend() {
    String temp = _sendMessageC.text;
    Message newMessage = Message(sender: humanUser, msg: _sendMessageC.text);
    setState(() {
      chats.add(newMessage);
      _sendMessageC.clear();
    });
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn);
    });
    getResponseFromBot(msg: temp);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: chats.length,
              itemBuilder: (context, i) {
                return MessageBubble(
                  message: chats[i],
                );
              },
            ),
          ),
        ),
        TypeMessageBox(
          controller: _sendMessageC,
          onPressed: () {
            onMessageSend();
          },
        ),
      ],
    );
  }
}
