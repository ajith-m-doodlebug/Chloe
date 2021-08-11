import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/CreatedWidgets/inputField.dart';
import 'package:fin_tech_app/CreatedWidgets/inputPassword.dart';
import 'package:fin_tech_app/CreatedWidgets/longButton.dart';
import 'package:fin_tech_app/Home/home.dart';
import 'package:fin_tech_app/LocalStorage/landingPage.dart';
import 'package:fin_tech_app/LocalStorage/userData.dart';
import 'package:fin_tech_app/OnBoarding/ForgotPassword/FindAccount/findAccount.dart';
import 'package:fin_tech_app/OnBoarding/SignUp/signUp.dart';
import 'package:fin_tech_app/PageTransition/rightSlide.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();

  late String _checkPassword;
  bool _loading = false;
  late String _userID;

  String buttonText = 'Log In';
  bool buttonDisabled = false;

  _cleanTheFields() async {
    _emailC.clear();
    _passwordC.clear();
  }

  _validateUser() async {
    var value =
        await usersInstance.where('email', isEqualTo: _emailC.text).get();
    if (value.docs.isNotEmpty) {
      value.docs.forEach((value) {
        setState(() {
          _checkPassword = value.data()['password'];
          _userID = value.id;
        });
      });
    } else {
      setState(() {
        _checkPassword = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputField(
            controller: _emailC,
            hintText: 'Email',
            onChanged: (value) {
              if (buttonDisabled) {
                setState(() {
                  buttonDisabled = false;
                  buttonText = 'Log In';
                });
              }
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the e-mail id';
              }
              return null;
            },
          ),
          InputPassword(
            controller: _passwordC,
            hintText: 'Password',
            onChanged: (value) {
              if (buttonDisabled) {
                setState(() {
                  buttonDisabled = false;
                  buttonText = 'Log In';
                });
              }
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the password';
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'Forgot your password?  ',
                  style: TextStyle(color: kHintTextColor),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, RightSlide(page: FindAccount()));
                },
                child: Text(
                  'Click here',
                  style: TextStyle(
                    color: kWhite,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          LongButton(
            text: buttonText,
            loading: _loading,
            onPressed: buttonDisabled
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _loading = true;
                      });
                      await _validateUser();
                      if (_passwordC.text == _checkPassword) {
                        await setUserDataLogIn(userID: _userID);
                        await _cleanTheFields();
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
                          buttonText = 'Incorrect Credentials';
                        });
                      }
                    }
                  },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Don\'t have an account? ',
                    style: TextStyle(color: kHintTextColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, RightSlide(page: SignUp()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: kWhite,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
