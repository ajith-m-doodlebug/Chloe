import 'dart:math';
import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/CreatedWidgets/inputField.dart';
import 'package:fin_tech_app/CreatedWidgets/longButton.dart';
import 'package:fin_tech_app/Home/home.dart';
import 'package:fin_tech_app/LocalStorage/landingPage.dart';
import 'package:fin_tech_app/LocalStorage/userData.dart';
import 'package:fin_tech_app/PageTransition/rightSlide.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';

class OtpVerificationForm extends StatefulWidget {
  final String email;
  final String name;
  final String password;

  const OtpVerificationForm({
    required this.email,
    required this.name,
    required this.password,
  });

  @override
  _OtpVerificationFormState createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  final _formKey = GlobalKey<FormState>();
  final _otpC = TextEditingController();
  late String otpString;
  late String inputOtp;

  String buttonText = 'Verify me';
  bool buttonDisabled = false;

  late String _userID;
  bool _loading = false;

  @override
  void initState() {
    _sendOTPMail();
    super.initState();
  }

  _sendOTPMail() async {
    var otpGenerator = Random();
    int otp = 100000 + otpGenerator.nextInt(899999);
    setState(() {
      otpString = otp.toString();
    });
    print(otpString);
    var response = await http.get(Uri.parse(
        'https://budget-boom.herokuapp.com/ProjectBudget/SignUpOtp/${widget.email}/$otpString'));
    print(response.body);
  }

  _createUserID() {
    var userIDGenerator = Random();
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    setState(() {
      _userID = List.generate(
          15, (index) => _chars[userIDGenerator.nextInt(_chars.length)]).join();
    });
  }

  _sendWelcomeMail() async {
    var response = await http.get(Uri.parse(
        'https://budget-boom.herokuapp.com/ProjectBudget/WelcomeMail/${widget.email}/${widget.name}'));
    print(response.body);
  }

  _createUserInFirebase() async {
    _createUserID();
    var doc = await usersInstance.doc(_userID).get();
    if (!doc.exists) {
      usersInstance.doc(_userID).set({
        "name": widget.name,
        "email": widget.email,
        "password": widget.password,
        "budget": 0,
        "remaining": 0,
        "limit": 0,
      });
      await _sendWelcomeMail();
    } else {
      _createUserInFirebase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: kWhite,
                ),
                children: [
                  TextSpan(text: 'Hello, ${widget.name}.'),
                  TextSpan(text: ' We have sent you an OTP to '),
                  TextSpan(
                    text: '${widget.email} \n',
                    style: TextStyle(
                      color: mainColor,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Please enter the 6 digit number to confirm your account. \n'
                        'Going back to the previous page will result in stopping the current action.',
                  ),
                ],
              ),
            ),
          ),
          InputField(
            controller: _otpC,
            hintText: 'OTP',
            onChanged: (value) {
              if (buttonDisabled) {
                setState(() {
                  buttonDisabled = false;
                  buttonText = 'Sign Up';
                });
              }
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the company\'s e-mail id';
              }
              return null;
            },
          ),
          LongButton(
            loading: _loading,
            text: buttonText,
            onPressed: buttonDisabled
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      if (_otpC.text == otpString) {
                        setState(() {
                          _loading = true;
                        });
                        await _createUserInFirebase();
                        await setUserDataSignUp(
                          name: widget.name,
                          email: widget.email,
                          password: widget.password,
                          userID: _userID,
                          budget: 0.0,
                          remaining: 0.0,
                          limit: 0.0,
                        );
                        await setHomeLandingPage();
                        setState(() {
                          _loading = false;
                        });
                        Navigator.pushAndRemoveUntil(context,
                            RightSlide(page: Home()), (route) => false);
                      } else {
                        setState(() {
                          _loading = false;
                          buttonDisabled = true;
                          buttonText = 'Incorrect OTP';
                        });
                      }
                    }
                  },
          ),
        ],
      ),
    );
  }
}
