import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/CreatedWidgets/inputField.dart';
import 'package:fin_tech_app/CreatedWidgets/inputPassword.dart';
import 'package:fin_tech_app/CreatedWidgets/longButton.dart';
import 'package:fin_tech_app/OnBoarding/LogIn/logIn.dart';
import 'package:fin_tech_app/PageTransition/rightSlide.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'optVerification.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _emailC = TextEditingController();
  final _password1C = TextEditingController();
  final _password2C = TextEditingController();

  bool _loading = false;
  bool _emailAvailable = false;

  String buttonText = 'Sign Up';
  bool buttonDisabled = false;

  static final RegExp _name = RegExp(r'^[a-zA-Z\s]*$');
  static final RegExp _password =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  _checkEmail() async {
    var value =
        await usersInstance.where('email', isEqualTo: _emailC.text).get();
    if (value.docs.isEmpty) {
      setState(() {
        _emailAvailable = true;
      });
    } else {
      setState(() {
        _emailAvailable = false;
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
            controller: _nameC,
            hintText: 'Name',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your name';
              }
              if (!_name.hasMatch(value)) {
                return 'Name must contain only alphabets';
              }
              return null;
            },
          ),
          InputField(
            controller: _emailC,
            hintText: 'Email',
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
                return 'Please enter the your e-mail id';
              }
              if (!value.contains('@')) {
                return 'please enter a valid e-mail id';
              }
              return null;
            },
          ),
          InputPassword(
            controller: _password1C,
            hintText: 'Create Password',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the password';
              }
              if (!_password.hasMatch(value)) {
                return 'Password must be at least 8 characters. \n'
                    'With minimum one uppercase, one lowercase, \n'
                    'one number and one special character.';
              }
              return null;
            },
          ),
          InputPassword(
            controller: _password2C,
            hintText: 'Confirm Password',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please retype the password';
              }
              if (value != _password1C.text) {
                return 'Please retype the password correctly';
              }
              return null;
            },
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
                      await _checkEmail();
                      setState(() {
                        _loading = false;
                      });
                      if (_emailAvailable) {
                        setState(() {
                          Navigator.push(
                            context,
                            RightSlide(
                              page: OtpVerification(
                                name: _nameC.text,
                                email: _emailC.text,
                                password: _password1C.text,
                              ),
                            ),
                          );
                        });
                      } else {
                        setState(() {
                          _loading = false;
                          buttonDisabled = true;
                          buttonText = 'Email Already In Use';
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
                    'Already have an account? ',
                    style: TextStyle(color: kHintTextColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context, RightSlide(page: LogIn()), (route) => false);
                  },
                  child: Text(
                    'Log In',
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
