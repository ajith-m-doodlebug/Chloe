import 'dart:math';
import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/CreatedWidgets/inputField.dart';
import 'package:fin_tech_app/CreatedWidgets/longButton.dart';
import 'package:fin_tech_app/OnBoarding/ForgotPassword/ResetPassword/resetPassword.dart';
import 'package:fin_tech_app/PageTransition/rightSlide.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConfirmAccountForm extends StatefulWidget {
  final String name;
  final String email;
  final String userID;

  ConfirmAccountForm({
    required this.name,
    required this.email,
    required this.userID,
  });

  @override
  _ConfirmAccountFormState createState() => _ConfirmAccountFormState();
}

class _ConfirmAccountFormState extends State<ConfirmAccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _otpC = TextEditingController();
  late String otpString;
  late String inputOtp;

  String buttonText = 'Verify me';
  bool buttonDisabled = false;
  bool _loading = false;

  @override
  void initState() {
    _sendOTPMail();
    super.initState();
  }

  Future<void> _sendOTPMail() async {
    var otpGenerator = Random();
    int otp = 100000 + otpGenerator.nextInt(899999);
    setState(() {
      otpString = otp.toString();
    });
    print(otpString);
    var response = await http.get(Uri.parse(
        'https://budget-boom.herokuapp.com/ProjectBudget/ResetPasswordOtp/${widget.email}/$otpString'));
    print(response.body);
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
                        Navigator.push(
                          context,
                          RightSlide(
                            page: ResetAccount(
                              name: widget.name,
                              email: widget.email,
                              userID: widget.userID,
                            ),
                          ),
                        );
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
