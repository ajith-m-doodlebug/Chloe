import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/CreatedWidgets/inputField.dart';
import 'package:fin_tech_app/CreatedWidgets/longButton.dart';
import 'package:fin_tech_app/OnBoarding/ForgotPassword/ConfirmAccount/confirmAccount.dart';
import 'package:fin_tech_app/PageTransition/rightSlide.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';

class FindAccountForm extends StatefulWidget {
  @override
  _FindAccountFormState createState() => _FindAccountFormState();
}

class _FindAccountFormState extends State<FindAccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();

  bool _loading = false;
  bool _foundAccount = false;

  late String _userID;
  late String _userName;

  String buttonText = 'Find account';
  bool buttonDisabled = false;

  _findAccount() async {
    var value =
        await usersInstance.where('email', isEqualTo: _emailC.text).get();
    if (value.docs.isNotEmpty) {
      value.docs.forEach((value) {
        setState(() {
          _userID = value.id;
          _userName = value.data()['name'];
          _foundAccount = true;
        });
      });
    } else {
      setState(() {
        _foundAccount = false;
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
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Text(
              'Help us find your account by entering the email you Signed In with.',
              style: TextStyle(color: kWhite),
            ),
          ),
          InputField(
            controller: _emailC,
            hintText: 'Email',
            onChanged: (value) {
              if (buttonDisabled) {
                setState(() {
                  buttonDisabled = false;
                  buttonText = 'Find account';
                });
              }
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the company\'s e-mail id';
              }
              if (!value.contains('@')) {
                return 'please enter a valid e-mail id';
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
                      await _findAccount();
                      setState(() {
                        _loading = false;
                      });
                      if (_foundAccount) {
                        setState(() {
                          Navigator.push(
                            context,
                            RightSlide(
                              page: ConfirmAccount(
                                name: _userName,
                                email: _emailC.text,
                                userID: _userID,
                              ),
                            ),
                          );
                        });
                      } else {
                        setState(() {
                          buttonDisabled = true;
                          buttonText = 'Account not found';
                        });
                      }
                    }
                  },
          )
        ],
      ),
    );
  }
}
