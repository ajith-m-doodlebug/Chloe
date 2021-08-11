import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Colors/colors.dart';
import 'Home/home.dart';
import 'OnBoarding/welcome.dart';
import 'LocalStorage/landingPage.dart';

final usersInstance = FirebaseFirestore.instance.collection('Users');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: backgroundColor, // navigation bar color
    statusBarColor: backgroundColor, // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fin-Tech',
      home: DecidePage(),
    );
  }
}

class DecidePage extends StatefulWidget {
  @override
  _DecidePageState createState() => _DecidePageState();
}

class _DecidePageState extends State<DecidePage> {
  late Widget goTo = DummyPage();

  @override
  void initState() {
    setPage();
    super.initState();
  }

  setPage() async {
    String page = await getLandingPage();
    if (page == 'Home') {
      print('home');
      setState(() {
        goTo = Home();
      });
    } else if (page == 'Welcome') {
      print('home');
      setState(() {
        goTo = Welcome();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: goTo,
    );
  }
}

class DummyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
